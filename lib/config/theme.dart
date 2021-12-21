import 'package:flutter/material.dart';
import 'package:lettutor_app/config/colors.dart';

class AppTheme {
  static final ThemeData themeData = new ThemeData(
    brightness: Brightness.light,
    primarySwatch: MaterialColor(
        AppColors.primaryColor[900].value, AppColors.primaryColor),
    primaryColor: AppColors.primaryColor[900],
    primaryColorBrightness: Brightness.light,
  );

  static final ThemeData themeDataDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor[200],
    primaryColorBrightness: Brightness.dark,
  );
}
