import 'package:flutter/cupertino.dart';
import 'package:lettutor_app/data/shared_preference/user_preferences.dart';
import 'package:lettutor_app/models/user.dart';

enum AuthStatus { NotLoggedIn, LoggedIn, LoggingIn }

class AuthProvider extends ChangeNotifier {
  AuthStatus _loggedInStatus = AuthStatus.NotLoggedIn;

  AuthStatus get loggedInStatus => _loggedInStatus;

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
      await UserPreferences().saveUser(User.data);
      _loggedInStatus = AuthStatus.LoggedIn;
      notifyListeners();
      return {'status': true, 'message': 'Successful', 'user': User.data};
    }

    _loggedInStatus = AuthStatus.NotLoggedIn;
    notifyListeners();
    return {'status': false, 'message': 'Falied', 'user': null};
  }
}
