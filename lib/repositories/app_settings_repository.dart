import 'package:flutter/cupertino.dart';
import 'package:lettutor_app/data/shared_preferences/shared_prefs_provider.dart';

class AppSettingsRepository {
  final SharedPrefsHelper sharedPrefsHelper;
  AppSettingsRepository({@required this.sharedPrefsHelper});

  void changeBrightnessToDark(bool isDarkTheme) =>
      sharedPrefsHelper.changeBrightnessToDark(isDarkTheme);

  void changeLanguage(String locale) =>
      sharedPrefsHelper.changeLanguage(locale);

  String get currentLanguageLocale => sharedPrefsHelper.currentLanguageLocale;

  bool get isDarkMode => sharedPrefsHelper.isDarkMode;
}
