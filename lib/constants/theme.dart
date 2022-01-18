import 'package:flutter/material.dart';
import 'package:lettutor_app/constants/colors.dart';

class AppTheme {
  static final ThemeData themeData = new ThemeData(
      brightness: Brightness.light,
      primarySwatch: MaterialColor(
          AppColors.primaryColor[700].value, AppColors.primaryColor),
      scaffoldBackgroundColor: Colors.blueGrey[50],
      backgroundColor: Colors.white,
      primaryColor: AppColors.primaryColor[500],
      primaryColorBrightness: Brightness.light,
      primaryIconTheme: IconThemeData(color: Colors.black, size: 24),
      cardColor: Colors.white,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xff707B8A),
          )),
      iconTheme: IconThemeData(
        color: Color(0xff707B8A),
      ),
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
      // scaffoldBackgroundColor: Color(0xff282832),
      scaffoldBackgroundColor: Color(0xff232934),
      backgroundColor: Color(0xff232934),
      primaryColor: AppColors.primaryColor[500],
      primarySwatch: MaterialColor(
          AppColors.primaryColor[700].value, AppColors.primaryColor),
      primaryColorBrightness: Brightness.dark,
      cardColor: Color(0xff2A313C),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Color(0xff202630)),
      appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff232934),
          iconTheme: IconThemeData(
            color: Color(0xff707B8A),
          )),
      iconTheme: IconThemeData(
        color: Color(0xff707B8A),
      ),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          bodyText2: TextStyle(fontSize: 14, color: Color(0xffEFEEF2)),
          headline6: TextStyle(fontSize: 18),
          headline5: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor[500],
          ),
          headline4: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          caption: TextStyle(color: Colors.grey, fontSize: 13),
          subtitle1: TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
          subtitle2: TextStyle(fontSize: 13, color: Colors.blueGrey[50])));
}
