import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final IconData iconData;
  final String initialValue;
  final TextInputType keyboardType;
  final Function(String) validator;
  final Function(String) onSaved;
  final bool isPasswordTextField;
  CustomTextField(
      {@required this.title,
      this.controller,
      @required this.iconData,
      this.keyboardType,
      this.initialValue,
      this.isPasswordTextField = false,
      this.validator,
      this.onSaved});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
            initialValue: initialValue,
            controller: controller,
            decoration: InputDecoration(
              labelText: title,
              labelStyle: TextStyle(fontSize: 14),
              icon: Icon(
                iconData,
              ),
              // fillColor: Colors.grey[200],
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 0.5),
              ),
            ),
            validator: validator,
            onSaved: onSaved,
            keyboardType:
                keyboardType == null ? TextInputType.text : keyboardType,
            obscureText: isPasswordTextField ? true : false,
            enableSuggestions: isPasswordTextField ? false : true));
  }
}
