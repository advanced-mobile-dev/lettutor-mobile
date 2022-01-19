import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/forget_password/forget_password_bloc.dart';

import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/utils/device_utils.dart';
import 'package:lettutor_app/utils/validator.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordForm extends StatefulWidget {
  @override
  _ForgetPasswordFormState createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  var _formKey = GlobalKey<FormState>();
  String _email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('${state.errorMessage}')),
              );
          }
          if (state is ForgetPasswordSuccess) {
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
                          Text('${AppLocalizations.of(context).success}')
                        ],
                      ),
                      content: Text(
                          '${AppLocalizations.of(context).forgetPasswordSuccess}'
                          // "Please check your email for a link to reset your password.",
                          // textAlign: TextAlign.center,
                          ),
                      actions: [
                        TextButton(
                          child: Text('${AppLocalizations.of(context).close}'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ));
          }
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context).forgetPasswordContent,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                title: AppLocalizations.of(context).email,
                onSaved: (value) => {_email = value},
                validator: validateEmail,
                iconData: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 50,
              ),
              BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                builder: (context, state) {
                  if (state is ForgetPasswordInProgress) {
                    return SubmitButton(text: 'Loading ...', function: null);
                  }
                  return SubmitButton(
                      text: AppLocalizations.of(context).sendResetLink,
                      function: () {
                        DeviceUtils.hideKeyboard(context);
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          context
                              .read<ForgetPasswordBloc>()
                              .add(ForgetPasswordEvent(email: _email));
                        }
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
