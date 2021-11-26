import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/icons.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = new TextEditingController();
    final TextEditingController _passwordController =
        new TextEditingController();
    final TextEditingController _confirmPasswordController =
        new TextEditingController();

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: AppTheme.primaryColor,
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
      body: Container(
        padding: EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          children: <Widget>[
            CustomTextField(
              controller: _emailController,
              title: 'Email',
              iconData: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing * 3,
            ),
            CustomTextField(
              controller: _passwordController,
              title: 'Password',
              iconData: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              isPasswordTextField: true,
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing * 3,
            ),
            CustomTextField(
              controller: _confirmPasswordController,
              title: 'Confirm Password',
              iconData: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              isPasswordTextField: true,
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
