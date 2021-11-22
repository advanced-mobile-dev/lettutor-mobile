import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/email_text_field.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationAppBar(
        title: 'Forget Password',
      ),
      body: Container(
        padding: EdgeInsets.all(AppSizes.pagePadding),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Reset password',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: AppSizes.largeTextSize,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Text('Please enter your email address to search for your account.',
                maxLines: 2,
                style: TextStyle(
                    fontSize: AppSizes.normalTextSize,
                    fontWeight: FontWeight.w300)),
            SizedBox(
              height: 30,
            ),
            EmailTextField(controller: _emailController),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            SubmitButton(text: 'Send reset link', function: () {})
          ],
        ),
      ),
    );
  }
}
