import 'package:flutter/cupertino.dart';
import 'package:lettutor_app/data/shared_preference/shared_prefs_provider.dart';

class AppSettingsProvider extends ChangeNotifier {
  bool _isDarkTheme;
  bool get isDarkTheme => _isDarkTheme;
  String _locale;
  String get locale => _locale;

  AppSettingsProvider(bool darkTheme, String locale) {
    _isDarkTheme = darkTheme;
    _locale = locale;
  }

  void setIsDarkTheme(bool isDarkTheme) {
    SharedPrefsProvider.changeBrightnessToDark(isDarkTheme);
    _isDarkTheme = isDarkTheme;
    notifyListeners();
  }

  void setLanguage(String locale) {
    SharedPrefsProvider.changeLanguage(locale);
    print(locale);
    _locale = locale;
    notifyListeners();
  }
}
