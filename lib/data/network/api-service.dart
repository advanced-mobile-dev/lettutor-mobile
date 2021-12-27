import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor_app/data/network/rest-client.dart';
import 'package:lettutor_app/models/user/user-token.dart';
import 'package:lettutor_app/models/user/user.dart';

class ApiService {
  static final RestClient _apiClient = RestClient();

  Future<User> login(String email, String password) async {
    final String endpoint = '/auth/login';
    final Response response = await _apiClient
        .post('$endpoint', body: {"email": email, "password": password});
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  facebookLogin(String token) async {
    final String endpoint = '/auth/facebook';
    final Response response = await _apiClient.post('$endpoint', body: {
      "access_token": token,
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  googleLogin(String token) async {
    final String endpoint = '/auth/google';
    final Response response = await _apiClient.post('$endpoint', body: {
      "access_token": token,
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  getUserInfo(String token) async {
    final String endpoint = '/user/info';
    final Response response = await _apiClient
        .get('$endpoint', headers: {"Authorization": 'Bearer $token'});
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      return user;
    }
    return null;
  }
}
