import 'package:flutter/cupertino.dart';
import 'package:lettutor_app/data/network/api-service.dart';
import 'package:lettutor_app/data/shared_preference/shared_prefs_provider.dart';
import 'package:lettutor_app/models/user.dart';
import 'package:lettutor_app/models/user/user.dart';

enum AuthStatus { NotLoggedIn, LoggedIn }

class UserProvider extends ChangeNotifier {
  UserTmp _user;
  UserTmp get user => _user;
  bool _loading = false;
  bool get loading => _loading;

  AuthStatus _loggedInStatus = AuthStatus.NotLoggedIn;
  AuthStatus get loggedInStatus => _loggedInStatus;

  void init() {
    if (SharedPrefsProvider.user != null &&
        SharedPrefsProvider.user.token != null) {
      _user = SharedPrefsProvider.user;
      _loggedInStatus = AuthStatus.LoggedIn;
    } else {
      SharedPrefsProvider.removeUser();
      _loggedInStatus = AuthStatus.NotLoggedIn;
    }
  }

  void setUser(UserTmp user) {
    _user = user;
    if (user != null) {
      notifyListeners();
    }
  }

  Future login(String email, String password) async {
    String message = '';
    bool result = false;
    _loading = true;
    notifyListeners();
    User user;
    try {
      user = await ApiService().login(email, password);
      if (user != null) {
        SharedPrefsProvider.saveUser(user);
        _user = SharedPrefsProvider.user;
        _loggedInStatus = AuthStatus.LoggedIn;
        result = true;
      } else {
        _loggedInStatus = AuthStatus.NotLoggedIn;
      }
    } catch (err) {
      _loggedInStatus = AuthStatus.NotLoggedIn;
      print(err);
    } finally {
      _loading = false;
    }
    notifyListeners();
    return {
      'status': result,
      'message': message,
    };
  }

  Future facebookLogin(String token) async {
    String message = '';
    bool result = false;
    _loading = true;
    notifyListeners();
    User user;
    try {
      user = await ApiService().facebookLogin(token);
      if (user != null) {
        SharedPrefsProvider.saveUser(user);
        _user = SharedPrefsProvider.user;
        print(_user);
        _loggedInStatus = AuthStatus.LoggedIn;
        result = true;
      } else {
        _loggedInStatus = AuthStatus.NotLoggedIn;
      }
    } catch (err) {
      _loggedInStatus = AuthStatus.NotLoggedIn;
      print(err);
    } finally {
      _loading = false;
    }
    notifyListeners();
    return {
      'status': result,
      'message': message,
    };
  }

  Future googleLogin(String token) async {
    String message = '';
    bool result = false;
    _loading = true;
    notifyListeners();
    User user;
    try {
      user = await ApiService().googleLogin(token);
      if (user != null) {
        SharedPrefsProvider.saveUser(user);
        _user = SharedPrefsProvider.user;
        _loggedInStatus = AuthStatus.LoggedIn;
        result = true;
      } else {
        _loggedInStatus = AuthStatus.NotLoggedIn;
      }
    } catch (err) {
      _loggedInStatus = AuthStatus.NotLoggedIn;
      print(err);
    } finally {
      _loading = false;
    }
    notifyListeners();
    return {
      'status': result,
      'message': message,
    };
  }
}
