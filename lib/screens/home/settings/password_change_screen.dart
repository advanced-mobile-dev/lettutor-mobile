import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordChangeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).changePassword,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            children: <Widget>[
              CustomTextField(
                title: AppLocalizations.of(context).currentPassword,
                controller: null,
                iconData: Icons.lock,
                isPasswordTextField: true,
              ),
              SizedBox(height: AppSizes.verticalItemSpacing * 3),
              CustomTextField(
                title: AppLocalizations.of(context).newPassword,
                controller: null,
                iconData: Icons.lock,
                isPasswordTextField: true,
              ),
              SizedBox(height: AppSizes.verticalItemSpacing * 3),
              CustomTextField(
                title: AppLocalizations.of(context).confirmPassword,
                controller: null,
                iconData: Icons.lock,
                isPasswordTextField: true,
              ),
              SizedBox(
                height: AppSizes.verticalItemSpacing * 5,
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
