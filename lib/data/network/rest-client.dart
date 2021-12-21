import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lettutor_app/data/network/exceptions/api-exception.dart';

class RestClient {
  RestClient._();
  static final RestClient _apiClient = RestClient._();
  factory RestClient() {
    return _apiClient;
  }

  static const _baseUrl = 'https://sandbox.api.lettutor.com';
  static const _timeout = 10;

  Future<dynamic> get(String path, {Map<String, String> headers, params}) {
    var uri = Uri.http(_baseUrl, path, params);
    return http
        .get(uri, headers: headers)
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse)
        .catchError((error) {
      throw FetchDataException('$error');
    });
  }

  Future<dynamic> post(String path,
      {Map<String, String> headers, body, params}) {
    var uri = Uri.http(_baseUrl, path, params);
    return http
        .post(uri, headers: headers, body: body)
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse)
        .catchError((error) {
      throw FetchDataException('$error');
    });
  }

  Future<dynamic> put(path, {Map<String, String> params, headers, body}) {
    var uri = Uri.http(_baseUrl, path, params);
    return http
        .put(uri, headers: headers, body: body)
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse)
        .catchError((error) {
      throw FetchDataException('$error');
    });
  }

  Future<dynamic> delete(path, {Map<String, String> headers, body, params}) {
    var uri = Uri.http(_baseUrl, path, params);
    return http
        .delete(uri, headers: headers, body: body)
        .timeout(Duration(seconds: _timeout))
        .then(_handleResponse)
        .catchError((error) {
      throw FetchDataException('$error');
    });
  }

  _handleResponse(http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300) {
      switch (statusCode) {
        case 400:
          throw BadRequestException(response.body.toString());
        case 401:
        case 403:
          throw UnauthorisedException(response.body.toString());
        case 500:
        default:
          throw FetchDataException('status-code:${response.statusCode}');
      }
    }
    return response;
  }
}
