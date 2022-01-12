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
  final bool readOnly;
  final bool autoFocus;
  final Function onTap;
  final int maxLines;
  CustomTextField(
      {@required this.title,
      this.controller,
      @required this.iconData,
      this.keyboardType,
      this.initialValue,
      this.isPasswordTextField = false,
      this.validator,
      this.onSaved,
      this.readOnly = false,
      this.autoFocus = false,
      this.onTap,
      this.maxLines = 1});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
            maxLines: maxLines,
            onTap: onTap,
            initialValue: initialValue,
            controller: controller,
            decoration: InputDecoration(
              labelText: title,
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
            autofocus: autoFocus,
            readOnly: readOnly,
            validator: validator,
            onSaved: onSaved,
            keyboardType:
                keyboardType == null ? TextInputType.text : keyboardType,
            obscureText: isPasswordTextField ? true : false,
            enableSuggestions: isPasswordTextField ? false : true));
  }
}
