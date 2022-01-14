import 'package:flutter/material.dart';

import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).forgetPassword,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).forgetPasswordContent,
              maxLines: 2,
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
              title: AppLocalizations.of(context).email,
              controller: _emailController,
              iconData: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 50,
            ),
            SubmitButton(
                text: AppLocalizations.of(context).sendResetLink,
                function: () {})
          ],
        ),
      ),
    );
  }
}
