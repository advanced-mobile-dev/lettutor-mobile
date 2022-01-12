import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/app_settings/app_settings_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
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
            child: Text('Advanced settings',
                style: TextStyle(
                    fontSize: AppSizes.smallTextSize, color: Colors.grey[600])),
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
                  style: TextStyle(
                      fontSize: AppSizes.normalTextSize,
                      fontWeight: FontWeight.normal),
                ),
                BlocBuilder<AppSettingsBloc, AppSettingsState>(
                    builder: (context, state) => Switch(
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
