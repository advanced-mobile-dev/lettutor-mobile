import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final IconData iconData;
  final TextInputType keyboardType;
  final bool isPasswordTextField;
  CustomTextField(
      {@required this.title,
      @required this.controller,
      @required this.iconData,
      this.keyboardType,
      this.isPasswordTextField = false});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: title,
              labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
              icon: Icon(iconData, color: AppTheme.primaryColor),
              fillColor: Colors.grey[200],
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: AppTheme.primaryColor, width: 0.5),
              ),
              focusColor: AppTheme.primaryColor,
            ),
            keyboardType:
                keyboardType == null ? TextInputType.text : keyboardType,
            obscureText: isPasswordTextField ? true : false,
            enableSuggestions: isPasswordTextField ? false : true));
  }
}
