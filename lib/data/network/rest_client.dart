import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:lettutor_app/data/network/exceptions/api_exception.dart';

class RestClient {
  static const _baseUrl = 'sandbox.api.lettutor.com';
  static const _timeout = 20;
  final BaseClient httpClient;
  RestClient(this.httpClient);

  Future<dynamic> get(String path,
      {Map<String, String> headers, Map<String, dynamic> params}) {
    var uri = Uri.https(_baseUrl, path, params);
    print(uri);
    return httpClient
        .get(
          uri,
          headers: headers,
        )
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse);
  }

  Future<dynamic> post(String path,
      {Map<String, String> headers,
      Map<String, dynamic> params,
      Map<String, dynamic> body}) {
    var uri = Uri.https(_baseUrl, path, params);
    return httpClient
        .post(uri, headers: headers, body: jsonEncode(body))
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse);
  }

  Future<dynamic> put(
    path, {
    Map<String, String> params,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) {
    var uri = Uri.https(_baseUrl, path, params);
    return httpClient
        .put(uri, headers: headers, body: jsonEncode(body))
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse);
  }

  Future<dynamic> delete(
    path, {
    Map<String, String> params,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) {
    var uri = Uri.https(_baseUrl, path, params);
    return httpClient
        .delete(uri, headers: headers, body: jsonEncode(body))
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse);
  }

  _handleResponse(http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 500) {
      final res = jsonDecode(response.body);
      final message = res['message'];
      print(message);
      throw ApiException(message, statusCode);
    }
    if (statusCode < 200 || statusCode >= 300) {
      throw ApiException(response.body.toString(), statusCode);
    }
    return response;
  }
}
