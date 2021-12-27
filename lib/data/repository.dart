import 'package:lettutor_app/data/network/api-service.dart';
import 'package:lettutor_app/models/user/user-token.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences/shared_prefs_provider.dart';

class Repository {
  Repository._();
  static SharedPrefsHelper _sharedPrefsHelper;
  static ApiService _apiService;
  static init() async {
    _sharedPrefsHelper =
        SharedPrefsHelper(await SharedPreferences.getInstance());
    _apiService = ApiService();
  }

//app
  static void changeBrightnessToDark(bool isDarkTheme) =>
      _sharedPrefsHelper.changeBrightnessToDark(isDarkTheme);
  static void changeLanguage(String locale) =>
      _sharedPrefsHelper.changeLanguage(locale);
  static String get currentLanguageLocale =>
      _sharedPrefsHelper.currentLanguageLocale;
  static bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

//auth
  static get userToken => _sharedPrefsHelper.userToken;
  static void removeUserToken() => _sharedPrefsHelper.removeUserToken();
  static void saveUserToken(UserToken userToken) =>
      _sharedPrefsHelper.saveUserToken(userToken);

  static Future<User> login(String email, String password) async {
    final user = await _apiService.login(email, password);
    if (user != null) {
      Repository.saveUserToken(user.userToken);
      return user;
    }
    return null;
  }

  static Future<User> facebookLogin(String token) async {
    final user = await _apiService.facebookLogin(token);
    if (user != null) {
      Repository.saveUserToken(user.userToken);
      return user;
    }
    return null;
  }

  static Future<User> googleLogin(String token) async {
    final user = await _apiService.googleLogin(token);
    if (user != null) {
      Repository.saveUserToken(user.userToken);
      return user;
    }
    return null;
  }

  static getUserInfo() async {
    final UserToken userToken = _sharedPrefsHelper.userToken;
    if (userToken == null) return null;
    final user = await _apiService.getUserInfo(userToken.accessToken.token);
    return user;
  }

  //
}
