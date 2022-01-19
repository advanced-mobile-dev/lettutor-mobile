import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/forget_password/forget_password_bloc.dart';
import 'package:lettutor_app/repositories/authentication_repository.dart';
import 'package:lettutor_app/screens/forget_password/widgets/forget_password_form.dart';

import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: ApplicationAppBar(
          title: AppLocalizations.of(context).forgetPassword,
        ),
        body: BlocProvider(
          create: (_) => ForgetPasswordBloc(
              RepositoryProvider.of<AuthenticationRepository>(context)),
          child: ForgetPasswordForm(),
        ));
  }
}
