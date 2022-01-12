import 'package:flutter/material.dart';

class DeviceUtils {
  static hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
