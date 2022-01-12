import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/authentication/authentication_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/account_settings.dart';
import 'widgets/advanced_settings.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppLocalizations.of(context).settings,
                  style: Theme.of(context).textTheme.headline4),
              AccountSettings(),
              AdvancedSettings(),
              SizedBox(
                height: AppSizes.verticalItemSpacing * 3,
              ),
              SubmitButton(
                  text: AppLocalizations.of(context).logout,
                  function: () {
                    context.read<AuthenticationBloc>().add(LogoutEvent());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
