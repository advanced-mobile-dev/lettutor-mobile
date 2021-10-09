import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  PasswordTextField({@required this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Password',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14, color: AppTheme.mainColor)),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.mainColor),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.mainColor2),
                  borderRadius: BorderRadius.circular(10)),
            ),
            cursorColor: AppTheme.mainColor,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (!isValidPassword(value)) return 'Invalid password';
              return null;
            },
          )
        ]);
  }

  bool isValidPassword(String string) {
    return string.length >= 6;
  }
}
