import 'package:lettutor_app/data/shared_preference/constants/preferences.dart';
import 'package:lettutor_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsProvider {
  SharedPrefsProvider._();

  static SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void removeUser() {
    prefs.remove(Preferences.user_id);
    prefs.remove(Preferences.user_name);
    prefs.remove(Preferences.user_email);
    prefs.remove(Preferences.user_avatar);
    prefs.remove(Preferences.user_token);
    prefs.remove(Preferences.user_refreshtoken);
    prefs.remove(Preferences.is_logged_in);
  }

  static bool saveUser(User user) {
    prefs.setInt(Preferences.user_id, user.userId);
    prefs.setString(Preferences.user_name, user.name);
    prefs.setString(Preferences.user_email, user.email);
    prefs.setString(Preferences.user_avatar, user.avatar);
    prefs.setString(Preferences.user_token, user.token);
    prefs.setString(Preferences.user_refreshtoken, user.refreshToken);
    prefs.setBool(Preferences.is_logged_in, true);
    return true;
  }

  static User get user {
    int id = prefs.getInt(Preferences.user_id);
    String name = prefs.getString(Preferences.user_name);
    String email = prefs.getString(Preferences.user_email);
    String avatar = prefs.getString(Preferences.user_avatar);
    String token = prefs.getString(Preferences.user_token);
    String refreshToken = prefs.getString(Preferences.user_refreshtoken);
    return User(
        userId: id,
        name: name,
        email: email,
        avatar: avatar,
        token: token,
        refreshToken: refreshToken);
  }

  static bool get isLoggedIn {
    return prefs.getBool(Preferences.is_logged_in) ?? false;
  }

  static String get authToken {
    return prefs.getString(Preferences.auth_token);
  }

  static bool saveAuthToken(String authToken) {
    prefs.setString(Preferences.auth_token, authToken);
    return true;
  }

  static bool removeAuthToken() {
    prefs.remove(Preferences.auth_token);
    return true;
  }

  static Future<bool> get isDarkMode async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  static Future<void> changeBrightnessToDark(bool value) async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  static Future<String> get currentLanguage async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString(Preferences.current_language);
  }

  static Future<void> changeLanguage(String language) async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.setString(Preferences.current_language, language);
  }
}
