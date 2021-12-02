import 'package:flutter/material.dart';
import 'package:lettutor_app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String validateEmail(String email) {
  BuildContext context = MyApp.navigatorKey.currentContext;
  RegExp regExp = new RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (email.length == 0) {
    return '${AppLocalizations.of(context).email} ${AppLocalizations.of(context).isRequired}';
  }
  if (!regExp.hasMatch(email))
    return '${AppLocalizations.of(context).email} ${AppLocalizations.of(context).isInvalid}';
  return null;
}

String validatePassword(String password) {
  BuildContext context = MyApp.navigatorKey.currentContext;
  if (password.length == 0)
    return '${AppLocalizations.of(context).password} ${AppLocalizations.of(context).isRequired}';

  return null;
}
