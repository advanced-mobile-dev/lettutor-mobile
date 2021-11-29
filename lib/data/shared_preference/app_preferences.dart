import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class AppPreferences {
  Future<bool> get isDarkMode async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  Future<String> get currentLanguage async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.setString(Preferences.current_language, language);
  }
}
