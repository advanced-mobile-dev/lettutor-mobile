import 'package:flutter/material.dart';
import 'package:lettutor_app/config/colors.dart';

class AppTheme {
  // static const backgroundColor = Color(0xffFAFAFA);
  // static const primaryColor = Color(0xff08346F);
  // static const secondaryColor = Color(0xffEAF2FD);
  // static const mainColor3 = Color(0xff2F80ED);
  // static const unactiveColor = Color(0xffB9BCBE);
  // static const myGreyColor = Color(0xffE7E7E7);
  // static const textColor = Color(0xff626262);
  // static const redColor = Colors.red;

  static final ThemeData themeData = new ThemeData(
      brightness: Brightness.light,
      primarySwatch: MaterialColor(
          AppColors.primaryColor[900].value, AppColors.primaryColor),
      primaryColor: AppColors.primaryColor[900],
      primaryColorBrightness: Brightness.light,
      accentColor: AppColors.primaryColor[900],
      accentColorBrightness: Brightness.light);

  static final ThemeData themeDataDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor[200],
    primaryColorBrightness: Brightness.dark,
    accentColor: AppColors.primaryColor[200],
    accentColorBrightness: Brightness.dark,
  );
}
