import 'package:flutter/material.dart';
import 'package:lettutor_app/config/colors.dart';

class AppTheme {
  static final ThemeData themeData = new ThemeData(
      brightness: Brightness.light,
      primarySwatch: MaterialColor(
          AppColors.primaryColor[500].value, AppColors.primaryColor),
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.blueGrey[50],
      primaryColor: AppColors.primaryColor[500],
      primaryColorBrightness: Brightness.light,
      iconTheme: IconThemeData(
        color: AppColors.primaryColor[500],
      ),
      primaryIconTheme: IconThemeData(color: Colors.black, size: 24),
      cardColor: Colors.white,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
        color: Colors.black,
      )),
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        bodyText2: TextStyle(fontSize: 14),
        headline6: TextStyle(fontSize: 18),
        headline5: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor[500],
        ),
        headline4: TextStyle(
            fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        caption: TextStyle(color: Colors.grey, fontSize: 13),
        subtitle1: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        subtitle2: TextStyle(fontSize: 13, color: Colors.blueGrey[900]),
      ));

  static final ThemeData themeDataDark = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xff282832),
      backgroundColor: Color(0xff1A1B25),
      primaryColor: AppColors.primaryColor[500],
      primarySwatch: MaterialColor(
          AppColors.primaryColor[500].value, AppColors.primaryColor),
      primaryColorBrightness: Brightness.dark,
      cardColor: Color(0xff333436),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Color(0xff282832)),
      // cardColor: Color(0xff282832),
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
        color: Colors.white,
      )),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          bodyText2: TextStyle(fontSize: 14, color: Color(0xffEFEEF2)),
          headline6: TextStyle(fontSize: 18),
          headline5: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          caption: TextStyle(color: Colors.grey, fontSize: 13),
          subtitle1: TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
          subtitle2: TextStyle(fontSize: 13, color: Colors.blueGrey[50])));
}
