import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/config/utility.dart';
import 'package:lettutor_app/screens/authentication/forget_password_screen.dart';
import 'package:lettutor_app/screens/home/home_screen.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/flat_button.dart';
import 'package:lettutor_app/widgets/icons.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = new TextEditingController();
    final TextEditingController _passwordController =
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
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: AppSizes.verticalItemSpacing * 4,
            ),
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
              height: AppSizes.verticalItemSpacing * 2,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: AppFlatButton(
                  text: 'Forget password?',
                  function: () {
                    Navigator.of(context)
                        .pushNamed(LettutorRoutes.forgetPassword);
                  }),
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing * 2,
            ),
            SubmitButton(
                text: 'Login',
                function: () {
                  Navigator.of(context).pushNamed(LettutorRoutes.home);
                }),
            SizedBox(
              height: AppSizes.verticalItemSpacing * 2,
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
