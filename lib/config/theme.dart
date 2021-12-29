import 'package:flutter/material.dart';
import 'package:lettutor_app/config/colors.dart';

class AppTheme {
  static final ThemeData themeData = new ThemeData(
      brightness: Brightness.light,
      primarySwatch: MaterialColor(
          AppColors.primaryColor[900].value, AppColors.primaryColor),
      scaffoldBackgroundColor: Colors.grey[50],
      primaryColor: AppColors.primaryColor[900],
      primaryColorBrightness: Brightness.light,
      iconTheme: IconThemeData(color: AppColors.primaryColor[900]));

  static final ThemeData themeDataDark = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor[200],
      primaryColorBrightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(color: AppColors.primaryColor[200]));
}
