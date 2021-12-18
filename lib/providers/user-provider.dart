import 'package:flutter/cupertino.dart';
import 'package:lettutor_app/data/shared_preference/shared_prefs_provider.dart';
import 'package:lettutor_app/models/user.dart';

enum AuthStatus { NotLoggedIn, LoggedIn, LoggingIn }

class UserProvider extends ChangeNotifier {
  User _user;
  User get user => _user;
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

  void setUser(User user) {
    _user = user;
    if (user != null) {
      notifyListeners();
    }
  }

  void setStatus(AuthStatus authStatus) {
    _loggedInStatus = authStatus;
  }

  Future login(String email, String password) async {
    _loggedInStatus = AuthStatus.LoggingIn;
    notifyListeners();
    //call api
    await Future.delayed(Duration(seconds: 2));
    //

    if (email == 'admin@admin.com' && password == '123') {
      SharedPrefsProvider.saveUser(User.data);
      _loggedInStatus = AuthStatus.LoggedIn;
      notifyListeners();
      return {'status': true, 'message': 'Successful', 'user': User.data};
    }

    _loggedInStatus = AuthStatus.NotLoggedIn;
    notifyListeners();
    return {'status': false, 'message': 'Falied', 'user': null};
  }
}
