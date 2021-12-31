import 'dart:async';

import 'package:lettutor_app/data/network/api_service.dart';
import 'package:lettutor_app/data/repository.dart';
import 'package:lettutor_app/models/user/user_token.dart';
import 'package:lettutor_app/models/user/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    UserToken userToken = Repository.sharedPrefsHelper.userToken;
    if (userToken == null)
      yield AuthenticationStatus.unknown;
    else {
      yield AuthenticationStatus.authenticated;
    }
    yield* _controller.stream;
  }

  Future<User> login(String email, String password) async {
    final user = await ApiService().login(email, password);
    print(user);
    if (user != null) {
      Repository.sharedPrefsHelper.saveUserToken(user.userToken);
      _controller.add(AuthenticationStatus.authenticated);
      return user;
    }
    return null;
  }

  Future<User> facebookLogin(String token) async {
    final user = await ApiService().facebookLogin(token);
    if (user != null) {
      Repository.sharedPrefsHelper.saveUserToken(user.userToken);
      _controller.add(AuthenticationStatus.authenticated);
      return user;
    }
    return null;
  }

  Future<User> googleLogin(String token) async {
    final user = await ApiService().googleLogin(token);
    print(user);
    if (user != null) {
      Repository.sharedPrefsHelper.saveUserToken(user.userToken);
      _controller.add(AuthenticationStatus.authenticated);
      return user;
    }
    return null;
  }

  void logout() {
    Repository.sharedPrefsHelper.removeUserToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<User> signUp(String email, String password) async {
    final User user = await ApiService().signUp(email, password);
    if (user != null) {
      Repository.sharedPrefsHelper.saveUserToken(user.userToken);
      if (user.isActivated) _controller.add(AuthenticationStatus.authenticated);
      return user;
    }
    return null;
  }

  void dispose() {
    _controller.close();
  }
}
