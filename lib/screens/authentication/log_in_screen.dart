import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/providers/auth-provider.dart';
import 'package:lettutor_app/providers/user-provider.dart';
import 'package:lettutor_app/utils/validator.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/flat_button.dart';
import 'package:lettutor_app/widgets/icons.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: ApplicationAppBar(
              title: 'Login',
            ),
            body: Container(
              padding: EdgeInsets.all(AppSizes.pagePadding),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: AppSizes.verticalItemSpacing * 4,
                    ),
                    CustomTextField(
                        title: 'Email',
                        iconData: Icons.email,
                        onSaved: (value) => {_email = value},
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing * 3,
                    ),
                    CustomTextField(
                      title: 'Password',
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
                          text: 'Forget password?',
                          function: () {
                            Navigator.of(context)
                                .pushNamed(LettutorRoutes.forgetPassword);
                          }),
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing * 2,
                    ),
                    context.watch<AuthProvider>().loggedInStatus ==
                            AuthStatus.LoggingIn
                        ? SubmitButton(text: 'Logging in...', function: null)
                        : SubmitButton(
                            text: 'Login',
                            function: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                final result = await context
                                    .read<AuthProvider>()
                                    .login(_email, _password);

                                if (result['status'] == true) {
                                  context
                                      .read<UserProvider>()
                                      .setUser(result['user']);
                                  Navigator.of(context)
                                      .pushNamed(LettutorRoutes.home);
                                } else {
                                  print(result['message']);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Username or Password is Incorrect')));
                                }
                              }

                              // Navigator.of(context).pushNamed(LettutorRoutes.home);
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
            )));
  }
}
