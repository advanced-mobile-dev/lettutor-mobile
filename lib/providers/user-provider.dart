// import 'package:flutter/cupertino.dart';
// import 'package:lettutor_app/data/network/api-service.dart';
// import 'package:lettutor_app/data/repository.dart';
// import 'package:lettutor_app/models/user/user.dart';

// enum AuthStatus { NotLoggedIn, LoggedIn }

// class UserProvider extends ChangeNotifier {
//   bool _loading = false;
//   User _user;

//   User get user => _user;
//   bool get loading => _loading;

//   AuthStatus _loggedInStatus = AuthStatus.NotLoggedIn;
//   AuthStatus get loggedInStatus => _loggedInStatus;

//   Future init() async {
//     try {
//       final user = await Repository.getUserInfo();
//       if (user != null) {
//         _user = user;
//         _loggedInStatus = AuthStatus.LoggedIn;
//       } else {
//         Repository.removeUserToken();
//         _loggedInStatus = AuthStatus.NotLoggedIn;
//       }
//     } catch (_) {
//       Repository.removeUserToken();
//       _loggedInStatus = AuthStatus.NotLoggedIn;
//     }
//   }

//   void setUser(User user) {
//     _user = user;
//     if (user != null) {
//       notifyListeners();
//     }
//   }

//   Future login(String email, String password) async {
//     String message = '';
//     bool result = false;
//     _loading = true;
//     notifyListeners();
//     User tmpUser;
//     try {
//       tmpUser = await Repository.login(email, password);
//       if (tmpUser != null) {
//         _user = tmpUser;
//         _loggedInStatus = AuthStatus.LoggedIn;
//         result = true;
//       } else {
//         _loggedInStatus = AuthStatus.NotLoggedIn;
//       }
//     } catch (err) {
//       _loggedInStatus = AuthStatus.NotLoggedIn;
//       print(err);
//     } finally {
//       _loading = false;
//     }
//     notifyListeners();
//     return {
//       'status': result,
//       'message': message,
//     };
//   }

//   Future facebookLogin(String token) async {
//     String message = '';
//     bool result = false;
//     _loading = true;
//     notifyListeners();
//     User user;
//     try {
//       user = await ApiService().facebookLogin(token);
//       if (user != null) {
//         _user = user;
//         print(_user);
//         _loggedInStatus = AuthStatus.LoggedIn;
//         result = true;
//       } else {
//         _loggedInStatus = AuthStatus.NotLoggedIn;
//       }
//     } catch (err) {
//       _loggedInStatus = AuthStatus.NotLoggedIn;
//       print(err);
//     } finally {
//       _loading = false;
//     }
//     notifyListeners();
//     return {
//       'status': result,
//       'message': message,
//     };
//   }

//   Future googleLogin(String token) async {
//     String message = '';
//     bool result = false;
//     _loading = true;
//     notifyListeners();
//     User user;
//     try {
//       user = await ApiService().googleLogin(token);
//       if (user != null) {
//         _user = user;
//         _loggedInStatus = AuthStatus.LoggedIn;
//         result = true;
//       } else {
//         _loggedInStatus = AuthStatus.NotLoggedIn;
//       }
//     } catch (err) {
//       _loggedInStatus = AuthStatus.NotLoggedIn;
//       print(err);
//     } finally {
//       _loading = false;
//     }
//     notifyListeners();
//     return {
//       'status': result,
//       'message': message,
//     };
//   }

//   void logout() {
//     Repository.removeUserToken();
//     _user = null;
//   }
// }
