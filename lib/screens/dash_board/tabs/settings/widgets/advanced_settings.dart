import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/app_settings/app_settings_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/routes.dart';
import 'setting_item.dart';

class AdvancedSettings extends StatelessWidget {
  const AdvancedSettings({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text('${AppLocalizations.of(context).advancedSettings}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.grey[600], fontSize: 13)),
          ),
          SizedBox(
            height: 10,
          ),
          SettingItem(
            title: AppLocalizations.of(context).language,
            function: () {
              Navigator.of(context).pushNamed(LettutorRoutes.languageSetting);
            },
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).darkMode,
                ),
                BlocBuilder<AppSettingsBloc, AppSettingsState>(
                    builder: (context, state) => Switch(
                          activeColor: Theme.of(context).primaryColor,
                          value: state.isDarkTheme,
                          onChanged: (bool value) {
                            context
                                .read<AppSettingsBloc>()
                                .add(ThemeChangedEvent(isDarkTheme: value));
                          },
                        ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
