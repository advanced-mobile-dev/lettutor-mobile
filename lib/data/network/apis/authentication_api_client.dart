import 'dart:convert';
import 'package:http/http.dart';
import 'package:lettutor_app/data/network/rest_client.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/models/user/user_token.dart';

class AuthenticationApiClient {
  RestClient _restClient;
  AuthenticationApiClient({BaseClient httpClient}) {
    _restClient = new RestClient(httpClient);
  }

  Future<User> login(String email, String password) async {
    final String endpoint = '/auth/login';
    final Response response = await _restClient
        .post('$endpoint', body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  Future<User> facebookLogin(String token) async {
    final String endpoint = '/auth/facebook';
    final Response response = await _restClient.post('$endpoint', body: {
      'access_token': token,
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  Future<User> googleLogin(String token) async {
    final String endpoint = '/auth/google';
    final Response response = await _restClient.post('$endpoint', body: {
      'access_token': token,
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  Future<User> signUp(String email, String password) async {
    final String endpoint = '/auth/register';
    final body = {"email": email, "password": password};
    final Response response = await _restClient.post('$endpoint', body: body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  Future<User> refreshToken(String refreshToken) async {
    final String endpoint = '/auth/refresh-token';
    final Response response = await _restClient.post('$endpoint',
        body: {'refreshToken': '$refreshToken', 'timezone': 7});
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  Future<bool> forgetPassword(String email) async {
    final String endpoint = '/user/forgotPassword';
    final body = {"email": email};
    final Response response = await _restClient.post('$endpoint', body: body);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
