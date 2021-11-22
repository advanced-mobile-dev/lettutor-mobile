import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/email_text_field.dart';
import 'package:lettutor_app/widgets/name_text_field.dart';
import 'package:lettutor_app/widgets/password_text_field.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class ProfileEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.backgroundColor,
      appBar: ApplicationAppBar(
        title: 'Edit profile',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        Tutor.data3.avatar,
                        width: 125,
                      ),
                    ),
                    Positioned(
                        top: 15,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.edit,
                            size: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: AppSizes.verticalItemSpacing),
              NameTextField(controller: null),
              SizedBox(height: AppSizes.verticalItemSpacing),
              EmailTextField(controller: null),
              SizedBox(height: AppSizes.verticalItemSpacing),
              PasswordTextField(controller: null),
              SizedBox(
                height: 30,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: SubmitButton(text: 'Save', function: () {}))
            ],
          ),
        ),
      ),
    );
  }
}
