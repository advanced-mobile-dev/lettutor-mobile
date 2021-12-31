import 'package:lettutor_app/data/repository.dart';

class AppSettingsRepository {
  void changeBrightnessToDark(bool isDarkTheme) =>
      Repository.sharedPrefsHelper.changeBrightnessToDark(isDarkTheme);

  void changeLanguage(String locale) =>
      Repository.sharedPrefsHelper.changeLanguage(locale);

  String get currentLanguageLocale =>
      Repository.sharedPrefsHelper.currentLanguageLocale;

  bool get isDarkMode => Repository.sharedPrefsHelper.isDarkMode;
}
