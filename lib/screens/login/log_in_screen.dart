import 'package:flutter/material.dart';
import 'package:lettutor_app/screens/login/widgets/login-body-widget.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: ApplicationAppBar(
              title: AppLocalizations.of(context).login,
            ),
            body: LoginBody()));
  }
}
