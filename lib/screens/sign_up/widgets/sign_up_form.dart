import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/config/utility.dart';
import 'package:lettutor_app/utils/validator.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _passwordController = new TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('${state.errorMessage}')),
              );
          }
          if (state is SignUpSuccess) {
            _passwordController.clear();
            _formKey.currentState.reset();
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Row(
                        children: [
                          Icon(
                            Icons.check_box_rounded,
                            size: 36,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Sign up successful")
                        ],
                      ),
                      content: Text(
                        "Please check your email to verify your account",
                        // textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextButton(
                          child: Text('Login now'),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LettutorRoutes.signIn);
                          },
                        ),
                      ],
                    ));
          }
        },
        child: Container(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            children: <Widget>[
              CustomTextField(
                title: AppLocalizations.of(context).email,
                onSaved: (value) => {_email = value},
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
                onSaved: (value) => _password = value,
                validator: validatePassword,
                keyboardType: TextInputType.visiblePassword,
                isPasswordTextField: true,
              ),
              SizedBox(
                height: AppSizes.verticalItemSpacing * 3,
              ),
              CustomTextField(
                // controller: _confirmPasswordController,
                title: AppLocalizations.of(context).confirmPassword,
                validator: (String confirmPassword) {
                  if (confirmPassword.length == 0)
                    return '${AppLocalizations.of(context).password} ${AppLocalizations.of(context).isRequired}';
                  if (confirmPassword != _passwordController.text)
                    return 'Password and confirm password does not match';
                  return null;
                },
                iconData: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                isPasswordTextField: true,
              ),
              SizedBox(
                height: 30,
              ),
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  if (state is SignUpInProgress) {
                    return SubmitButton(text: 'Loading ...', function: null);
                  }
                  return SubmitButton(
                      text: AppLocalizations.of(context).signUp,
                      function: () {
                        Utility.hideKeyboard(context);
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          context.read<SignUpBloc>().add(
                              SignUpEvent(email: _email, password: _password));
                        }
                      });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?  ',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                      child: Text("Login here",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              color: Colors.blue)),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, LettutorRoutes.signIn);
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
