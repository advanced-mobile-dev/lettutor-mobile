import 'package:flutter/material.dart';

import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).changePassword,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              CustomTextField(
                title: AppLocalizations.of(context).currentPassword,
                controller: null,
                iconData: Icons.lock,
                isPasswordTextField: true,
              ),
              SizedBox(height: 30),
              CustomTextField(
                title: AppLocalizations.of(context).newPassword,
                controller: null,
                iconData: Icons.lock,
                isPasswordTextField: true,
              ),
              SizedBox(height: 30),
              CustomTextField(
                title: AppLocalizations.of(context).confirmPassword,
                controller: null,
                iconData: Icons.lock,
                isPasswordTextField: true,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  child: SubmitButton(
                      text: AppLocalizations.of(context).save, function: () {}))
            ],
          ),
        ),
      ),
    );
  }
}
