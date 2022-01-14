import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:lettutor_app/repositories/authentication_repository.dart';
import 'package:lettutor_app/screens/sign_up/widgets/sign_up_form.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: ApplicationAppBar(
          title: AppLocalizations.of(context).signUp,
        ),
        body: BlocProvider(
          create: (_) => SignUpBloc(
              RepositoryProvider.of<AuthenticationRepository>(context)),
          child: SignUpForm(),
        ));
  }
}
