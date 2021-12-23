import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/providers/user-provider.dart';
import 'package:lettutor_app/utils/validator.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/flat_button.dart';
import 'package:lettutor_app/widgets/icons.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginBody extends StatefulWidget {
  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  String _email, _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.pagePadding),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: AppSizes.verticalItemSpacing * 4,
            ),
            CustomTextField(
                title: AppLocalizations.of(context).email,
                iconData: Icons.email,
                onSaved: (value) => {_email = value},
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail),
            SizedBox(
              height: AppSizes.verticalItemSpacing * 3,
            ),
            CustomTextField(
              title: AppLocalizations.of(context).password,
              iconData: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              onSaved: (value) => _password = value,
              validator: validatePassword,
              isPasswordTextField: true,
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing * 2,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: AppFlatButton(
                  text: '${AppLocalizations.of(context).forgetPassword}?',
                  function: () {
                    Navigator.of(context)
                        .pushNamed(LettutorRoutes.forgetPassword);
                  }),
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing * 2,
            ),
            context.watch<UserProvider>().loading
                ? SubmitButton(text: 'Logging in...', function: null)
                : SubmitButton(
                    text: AppLocalizations.of(context).login,
                    function: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        final result = await context
                            .read<UserProvider>()
                            .login(_email, _password);

                        if (result['status'] == true) {
                          context.read<UserProvider>().setUser(result['user']);
                          Navigator.of(context).pushNamed(LettutorRoutes.home);
                        } else {
                          print(result['message']);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .emailOrPasswordIsInCorrect)));
                        }
                      }
                    }),
            SizedBox(
              height: AppSizes.verticalItemSpacing * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildFacebookButton(context),
                SizedBox(
                  width: AppSizes.horizontalItemSpacing,
                ),
                _buildGoogleButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFacebookButton(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      onPrimary: Theme.of(context).primaryColor,
      primary: Colors.white,
      minimumSize: Size(100, 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    ),
    onPressed: () async {
      final LoginResult result = await FacebookAuth.instance
          .login(); // by default we request the email and the public profile
      if (result.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = result.accessToken;

        final loginResult =
            await context.read<UserProvider>().facebookLogin(accessToken.token);
        if (loginResult['status'] == true) {
          context.read<UserProvider>().setUser(loginResult['user']);
          Navigator.of(context).pushNamed(LettutorRoutes.home);
        } else {
          print(loginResult['message']);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  AppLocalizations.of(context).emailOrPasswordIsInCorrect)));
        }
      } else {
        print(result.status);
        print(result.message);
      }
    },
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
                fontSize: AppSizes.smallTextSize, fontWeight: FontWeight.w400),
          )
        ],
      ),
    ),
  );
}

Widget _buildGoogleButton(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      onPrimary: Theme.of(context).primaryColor,
      primary: Colors.white,
      minimumSize: Size(100, 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    ),
    onPressed: () async {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
      );
      await _googleSignIn.signOut();
      try {
        GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
        String accessToken;
        await googleSignInAccount.authentication.then((value) {
          accessToken = value.accessToken;
        });
        if (accessToken != null && accessToken.isNotEmpty) {
          final loginResult =
              await context.read<UserProvider>().googleLogin(accessToken);
          if (loginResult['status'] == true) {
            context.read<UserProvider>().setUser(loginResult['user']);
            Navigator.of(context).pushNamed(LettutorRoutes.home);
          } else {
            print(loginResult['message']);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    AppLocalizations.of(context).emailOrPasswordIsInCorrect)));
          }
        }
      } catch (error) {
        print(error);
      }
    },
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
                fontSize: AppSizes.smallTextSize, fontWeight: FontWeight.w400),
          )
        ],
      ),
    ),
  );
}