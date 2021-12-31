import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lettutor_app/data/network/api_exception.dart';

class RestClient {
  RestClient._();
  static final RestClient _apiClient = RestClient._();
  factory RestClient() {
    return _apiClient;
  }
  static const _baseUrl = 'sandbox.api.lettutor.com';
  static const _timeout = 10;

  Future<dynamic> get(String path,
      {Map<String, String> headers, Map<String, String> params}) {
    var uri = Uri.https(_baseUrl, path, params);
    print(uri);
    return http
        .get(
          uri,
          headers: headers,
        )
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse);
  }

  Future<dynamic> post(String path,
      {Map<String, String> headers,
      Map<String, dynamic> body,
      Map<String, dynamic> params}) {
    var uri = Uri.https(_baseUrl, path, params);
    print(jsonEncode(body));
    if (headers == null) headers = {};
    headers['Content-type'] = 'application/json';
    return http
        .post(uri, headers: headers, body: jsonEncode(body))
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse);
  }

  Future<dynamic> put(path, {Map<String, String> params, headers, body}) {
    var uri = Uri.https(_baseUrl, path, params);
    return http
        .put(uri, headers: headers, body: body)
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse);
  }

  Future<dynamic> delete(path, {Map<String, String> headers, body, params}) {
    var uri = Uri.https(_baseUrl, path, params);
    return http
        .delete(uri, headers: headers, body: body)
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse);
  }

  _handleResponse(http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 500) {
      final res = jsonDecode(response.body);
      final statusCode = res['statusCode'];
      final message = res['message'];
      throw FetchDataException(
        message,
        statusCode,
      );
    }
    if (statusCode < 200 || statusCode >= 300) {
      switch (statusCode) {
        case 400:
          throw BadRequestException(response.body.toString(), statusCode);
        case 401:
        case 403:
          throw UnauthorisedException(response.body.toString(), statusCode);
        default:
          throw FetchDataException(
            response.body,
            response.statusCode,
          );
      }
    }
    return response;
  }
}
