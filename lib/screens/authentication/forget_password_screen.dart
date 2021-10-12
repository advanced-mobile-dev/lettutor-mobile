import 'package:flutter/material.dart';
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
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Reset password',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Text('Please enter your email address to search for your account.',
                maxLines: 2,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
            SizedBox(
              height: 20,
            ),
            EmailTextField(controller: _emailController),
            SizedBox(
              height: 30,
            ),
            SubmitButton(text: 'Send reset link', function: () {})
          ],
        ),
      ),
    );
  }
}
