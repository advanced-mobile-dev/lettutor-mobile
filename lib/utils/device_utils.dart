import 'package:flutter/material.dart';

class DeviceUtils {
  static void hideKeyboard(context) {
    FocusScope.of(context).unfocus();
  }
}
