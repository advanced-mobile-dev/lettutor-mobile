import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const customGrey = Color(0xff707B8A);
  static const Map<int, Color> primaryColor = const <int, Color>{
    50: Color(0xFFFFF5E8),
    100: Color(0xFFFFE6C6),
    200: Color(0xFFFFD5A0),
    300: Color(0xFFFFC479),
    400: Color(0xFFFFB85D),
    500: const Color(0xFFFFAB40),
    600: Color(0xFFFFA43A),
    700: Color(0xFFFF9A32),
    800: Color(0xFFFF912A),
    900: Color(0xFFFF801C),
  };
}
