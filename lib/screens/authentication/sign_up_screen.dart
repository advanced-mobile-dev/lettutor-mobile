import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/config/utility.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/confirm_password_text_field.dart';
import 'package:lettutor_app/widgets/email_text_field.dart';
import 'package:lettutor_app/widgets/icons.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:lettutor_app/widgets/password_text_field.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = new TextEditingController();
    final TextEditingController _passwordController =
        new TextEditingController();
    final TextEditingController _confirmPasswordController =
        new TextEditingController();

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: AppTheme.mainColor,
      primary: Colors.white,
      minimumSize: Size(100, 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );

    Widget facebookSignUpButton = ElevatedButton(
      style: raisedButtonStyle,
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            AppIcons.facebookIcon,
            SizedBox(
              width: 5,
            ),
            Text(
              'Facebook',
              style: TextStyle(
                  fontSize: AppSizes.smallTextSize,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
    Widget googleSignUpButton = ElevatedButton(
      style: raisedButtonStyle,
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            AppIcons.googleIcon,
            SizedBox(
              width: 5,
            ),
            Text(
              'Google',
              style: TextStyle(
                  fontSize: AppSizes.smallTextSize,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ApplicationAppBar(
        title: 'Sign Up',
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: Container(
        padding: EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          children: <Widget>[
            EmailTextField(
              controller: _emailController,
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            PasswordTextField(
              controller: _passwordController,
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            ConfirmPasswordTextField(
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
            ),
            SizedBox(
              height: 30,
            ),
            SubmitButton(
                text: 'Sign Up',
                function: () {
                  // Utility.hideKeyboard(context);
                }),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Text('Or continue with',
                    style: TextStyle(
                        color: Colors.grey, fontSize: AppSizes.smallTextSize))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                facebookSignUpButton,
                SizedBox(
                  width: 10,
                ),
                googleSignUpButton
              ],
            ),
          ],
        ),
      ),
    );
  }
}
