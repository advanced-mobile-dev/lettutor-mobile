import 'dart:async';

import 'package:lettutor_app/blocs/forget_password/forget_password_bloc.dart';
import 'package:lettutor_app/data/network/apis/authentication_api_client.dart';
import 'package:lettutor_app/data/shared_preferences/shared_prefs_provider.dart';
import 'package:lettutor_app/models/user/user_token.dart';
import 'package:lettutor_app/models/user/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final AuthenticationApiClient authenticationApiClient;
  final SharedPrefsHelper sharedPrefsHelper;

  AuthenticationRepository(
      {this.authenticationApiClient, this.sharedPrefsHelper});

  Stream<AuthenticationStatus> get status async* {
    UserToken userToken = sharedPrefsHelper.userToken;
    if (userToken == null)
      yield AuthenticationStatus.unknown;
    else {
      yield AuthenticationStatus.authenticated;
    }
    yield* _controller.stream;
  }

  Future<User> login(String email, String password) async {
    final user = await authenticationApiClient.login(email, password);
    print(user);
    if (user != null) {
      sharedPrefsHelper.saveUserToken(user.userToken);
      _controller.add(AuthenticationStatus.authenticated);
      return user;
    }
    return null;
  }

  Future<User> facebookLogin(String token) async {
    final user = await authenticationApiClient.facebookLogin(token);
    if (user != null) {
      sharedPrefsHelper.saveUserToken(user.userToken);
      _controller.add(AuthenticationStatus.authenticated);
      return user;
    }
    return null;
  }

  Future<User> googleLogin(String token) async {
    final user = await authenticationApiClient.googleLogin(token);
    print(user);
    if (user != null) {
      sharedPrefsHelper.saveUserToken(user.userToken);
      _controller.add(AuthenticationStatus.authenticated);
      return user;
    }
    return null;
  }

  void logout() {
    sharedPrefsHelper.removeUserToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void removeUserInfo() {
    sharedPrefsHelper.removeUserToken();
  }

  Future<User> signUp(String email, String password) async {
    final User user = await authenticationApiClient.signUp(email, password);
    if (user != null) {
      if (user.isActivated) {
        sharedPrefsHelper.saveUserToken(user.userToken);
        _controller.add(AuthenticationStatus.authenticated);
      }
      return user;
    }
    return null;
  }

  Future<bool> forgetPassword(String email) async {
    final bool result = await authenticationApiClient.forgetPassword(email);
    return result;
  }

  Future<User> refreshToken() async {
    try {
      final user = await authenticationApiClient
          .refreshToken(sharedPrefsHelper.userToken.refreshToken);
      if (user != null) {
        sharedPrefsHelper.saveUserToken(user.userToken);
        print('success');
        return user;
      }
    } catch (_) {}
    return null;
  }

  void dispose() {
    _controller.close();
  }
}
