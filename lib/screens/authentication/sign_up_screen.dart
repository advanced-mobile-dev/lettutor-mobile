import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/utils/validator.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/icons.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = new TextEditingController();
    final TextEditingController _passwordController =
        new TextEditingController();
    final TextEditingController _confirmPasswordController =
        new TextEditingController();

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Theme.of(context).primaryColor,
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
        title: AppLocalizations.of(context).signUp,
      ),
      body: Container(
        padding: EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          children: <Widget>[
            CustomTextField(
              controller: _emailController,
              title: AppLocalizations.of(context).email,
              validator: validateEmail,
              iconData: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing * 3,
            ),
            CustomTextField(
              controller: _passwordController,
              title: AppLocalizations.of(context).password,
              iconData: Icons.lock,
              validator: validatePassword,
              keyboardType: TextInputType.visiblePassword,
              isPasswordTextField: true,
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing * 3,
            ),
            CustomTextField(
              controller: _confirmPasswordController,
              title: AppLocalizations.of(context).confirmPassword,
              validator: validatePassword,
              iconData: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              isPasswordTextField: true,
            ),
            SizedBox(
              height: 30,
            ),
            SubmitButton(
                text: AppLocalizations.of(context).signUp,
                function: () {
                  // Utility.hideKeyboard(context);
                }),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Text(AppLocalizations.of(context).orContinueWith,
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
