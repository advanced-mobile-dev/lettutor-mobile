import 'package:flutter/cupertino.dart';
import 'package:lettutor_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user;

  User get user => _user;

  void setUser(User user) {
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }
}
