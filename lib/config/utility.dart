import 'package:flutter/material.dart';

class Utility {
  static hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
