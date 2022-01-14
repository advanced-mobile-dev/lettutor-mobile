import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'key_service.dart';

String validateEmail(String email) {
  BuildContext context = KeyService.navigatorKey.currentContext;
  RegExp regExp = new RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (email.length == 0) {
    return '${AppLocalizations.of(context).email} ${AppLocalizations.of(context).isRequired}';
  }
  if (!regExp.hasMatch(email))
    return '${AppLocalizations.of(context).email} ${AppLocalizations.of(context).isInvalid}';
  return null;
}

String validatePassword(String password) {
  BuildContext context = KeyService.navigatorKey.currentContext;
  if (password.length == 0)
    return '${AppLocalizations.of(context).password} ${AppLocalizations.of(context).isRequired}';

  return null;
}
