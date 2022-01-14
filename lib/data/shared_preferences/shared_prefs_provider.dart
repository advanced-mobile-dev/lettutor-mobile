import 'package:lettutor_app/models/user/user_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String is_logged_in = "isLoggedIn";
  static const String auth_token = "authToken";
  static const String is_dark_mode = "is_dark_mode";
  static const String current_language = "current_language";
  static const String user_access_token = "userAccessToken";
  static const String user_refresh_token = "userRefreshToken";

  final SharedPreferences _prefs;
  SharedPrefsHelper(this._prefs);

  void removeUserToken() {
    _prefs.remove(user_access_token);
    _prefs.remove(user_refresh_token);
    _prefs.remove(is_logged_in);
  }

  bool saveUserToken(UserToken userToken) {
    _prefs.setString(user_access_token, userToken.accessToken);
    _prefs.setString(user_refresh_token, userToken.refreshToken);
    return true;
  }

  UserToken get userToken {
    String accessToken = _prefs.getString(user_access_token);
    String refreshToken = _prefs.getString(user_refresh_token);
    if (accessToken == null || refreshToken == null) return null;

    final userToken = UserToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    return userToken;
  }

  bool get isLoggedIn {
    return _prefs.getBool(is_logged_in) ?? false;
  }

  bool get isDarkMode {
    return _prefs.getBool(is_dark_mode) ?? false;
  }

  bool changeBrightnessToDark(bool value) {
    _prefs.setBool(is_dark_mode, value);
    return true;
  }

  String get currentLanguageLocale {
    return _prefs.getString(current_language) ?? 'en';
  }

  bool changeLanguage(String code) {
    _prefs.setString(current_language, code);
    return true;
  }
}
