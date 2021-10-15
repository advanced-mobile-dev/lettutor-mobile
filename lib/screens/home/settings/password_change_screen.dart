import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/confirm_password_text_field.dart';
import 'package:lettutor_app/widgets/email_text_field.dart';
import 'package:lettutor_app/widgets/name_text_field.dart';
import 'package:lettutor_app/widgets/password_text_field.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class PasswordChangeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.backgroundColor,
      appBar: ApplicationAppBar(
        title: 'Change password',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              PasswordTextField(controller: null),
              SizedBox(
                height: 10,
              ),
              PasswordTextField(
                controller: null,
                title: 'New password',
              ),
              SizedBox(
                height: 10,
              ),
              ConfirmPasswordTextField(
                  passwordController: null, confirmPasswordController: null),
              SizedBox(
                height: 30,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: SubmitButton(text: 'Save', function: () {}))
            ],
          ),
        ),
      ),
    );
  }
}
