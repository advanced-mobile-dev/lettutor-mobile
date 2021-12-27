import 'package:flutter/cupertino.dart';
import 'package:lettutor_app/data/repository.dart';

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
    Repository.changeBrightnessToDark(isDarkTheme);
    _isDarkTheme = isDarkTheme;
    notifyListeners();
  }

  void setLanguage(String locale) {
    Repository.changeLanguage(locale);
    print(locale);
    _locale = locale;
    notifyListeners();
  }
}
