import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  EmailTextField({@required this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Email',
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
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (!isValidEmail(value)) return 'Invalid email';
              return null;
            },
          ),
        ]);
  }

  bool isValidEmail(String string) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(string);
  }
}
