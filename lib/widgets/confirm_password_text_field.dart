import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';

class ConfirmPasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  ConfirmPasswordTextField(
      {@required this.passwordController,
      @required this.confirmPasswordController});
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Confirm Password',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14, color: AppTheme.mainColor)),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: confirmPasswordController,
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
              if (!hasMatchPassword(value))
                return 'Password and confirm password does not match';
              return null;
            },
          )
        ]);
  }

  bool isValidPassword(String string) {
    return string.length >= 6;
  }

  bool hasMatchPassword(String string) {
    return string == passwordController.text.toString();
  }
}
