import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lettutor_app/blocs/login/login_bloc.dart';
import 'package:lettutor_app/constants/assets.dart';

import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/utils/device_utils.dart';
import 'package:lettutor_app/utils/validator.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/flat_button.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email, _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('${state.errorMessage}')),
            );
        }
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                CustomTextField(
                    title: AppLocalizations.of(context).email,
                    iconData: Icons.email,
                    onSaved: (value) => {_email = value},
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail),
                SizedBox(
                  height: 30,
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
                  height: 20,
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
                  height: 20,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginInprogressState) {
                      return SubmitButton(
                          text: '${AppLocalizations.of(context).login}...',
                          function: null);
                    }
                    return SubmitButton(
                        text: AppLocalizations.of(context).login,
                        function: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            DeviceUtils.hideKeyboard(context);
                            context.read<LoginBloc>().add(LoginByEmailEvent(
                                email: _email, password: _password));
                          }
                        });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    child: Text(
                        '${AppLocalizations.of(context).createAnAccount}',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            color: Colors.blue)),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LettutorRoutes.signUp);
                    }),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: Text(AppLocalizations.of(context).orContinueWith,
                        style: Theme.of(context).textTheme.caption)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildFacebookButton(context),
                    SizedBox(
                      width: 10,
                    ),
                    _buildGoogleButton(context),
                  ],
                ),
              ],
            ),
          ),
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
      final facebookAuth = FacebookAuth.instance;
      await facebookAuth.logOut();
      final LoginResult result = await facebookAuth
          .login(); // by default we request the email and the public profile
      if (result.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = result.accessToken;
        context.read<LoginBloc>().add(LoginByFacebookToken(accessToken.token));
        // final loginResult =
        //     await context.read<UserProvider>().facebookLogin(accessToken.token);
        // if (loginResult['status'] == true) {
        //   context.read<UserProvider>().setUser(loginResult['user']);
        //   Navigator.of(context).pushNamed(LettutorRoutes.home);
        // } else {
        //   print(loginResult['message']);
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //       content: Text(
        //           AppLocalizations.of(context).emailOrPasswordIsInCorrect)));
        // }
      } else {
        print(result.status);
        print(result.message);
      }
    },
    child: Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(Assets.facebookIcon),
          SizedBox(
            width: 10,
          ),
          Text(
            'Facebook',
            style: TextStyle(color: Colors.black),
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
      // await _googleSignIn.signOut();
      try {
        GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
        String accessToken;
        await googleSignInAccount.authentication.then((value) {
          accessToken = value.accessToken;
        });
        if (accessToken != null && accessToken.isNotEmpty) {
          context.read<LoginBloc>().add(LoginByGoogleToken(accessToken));
          // final loginResult =
          //     await context.read<UserProvider>().googleLogin(accessToken);
          // if (loginResult['status'] == true) {
          //   context.read<UserProvider>().setUser(loginResult['user']);
          //   Navigator.of(context).pushNamed(LettutorRoutes.home);
          // } else {
          //   print(loginResult['message']);
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       content: Text(
          //           AppLocalizations.of(context).emailOrPasswordIsInCorrect)));
          // }
        }
      } catch (error) {
        print(error);
      }
    },
    child: Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          SvgPicture.asset(Assets.googleIcon),
          SizedBox(
            width: 10,
          ),
          Text(
            'Google',
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    ),
  );
}
