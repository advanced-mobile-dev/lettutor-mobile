import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class PasswordChangeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ApplicationAppBar(
        title: 'Change password',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            children: <Widget>[
              CustomTextField(
                title: 'Current password',
                controller: null,
                iconData: Icons.lock,
                isPasswordTextField: true,
              ),
              SizedBox(height: AppSizes.verticalItemSpacing * 3),
              CustomTextField(
                title: 'New password',
                controller: null,
                iconData: Icons.lock,
                isPasswordTextField: true,
              ),
              SizedBox(height: AppSizes.verticalItemSpacing * 3),
              CustomTextField(
                title: 'Confirm password',
                controller: null,
                iconData: Icons.lock,
                isPasswordTextField: true,
              ),
              SizedBox(
                height: AppSizes.verticalItemSpacing * 5,
              ),
              Container(child: SubmitButton(text: 'Save', function: () {}))
            ],
          ),
        ),
      ),
    );
  }
}
