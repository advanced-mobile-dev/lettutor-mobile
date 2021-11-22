import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/config/utility.dart';
import 'package:lettutor_app/screens/authentication/forget_password_screen.dart';
import 'package:lettutor_app/screens/home/home_screen.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/email_text_field.dart';
import 'package:lettutor_app/widgets/flat_button.dart';
import 'package:lettutor_app/widgets/icons.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:lettutor_app/widgets/password_text_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = new TextEditingController();
    final TextEditingController _passwordController =
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

    Widget facebookLoginButton = ElevatedButton(
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
    Widget googleLoginButton = ElevatedButton(
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
        title: 'Login',
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: Container(
        padding: EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          children: <Widget>[
            EmailTextField(controller: _emailController),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            PasswordTextField(
              controller: _passwordController,
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: AppFlatButton(
                  text: 'Forget password?',
                  function: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForgetPasswordScreen(),
                    ));
                  }),
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            SubmitButton(
                text: 'Login',
                function: () {
                  Utility.hideKeyboard(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                facebookLoginButton,
                SizedBox(
                  width: AppSizes.horizontalItemSpacing,
                ),
                googleLoginButton
              ],
            ),
          ],
        ),
      ),
    );
  }
}
