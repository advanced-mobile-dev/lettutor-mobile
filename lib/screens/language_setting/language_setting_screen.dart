import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/app_settings/app_settings_bloc.dart';
import 'package:lettutor_app/constants/languages.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).language,
      ),
      body: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) => Column(
            children: supportedLanguages
                .map((e) => GestureDetector(
                    onTap: () {
                      context
                          .read<AppSettingsBloc>()
                          .add(LanguageChangedEvent(locale: e.locale));
                    },
                    child: Container(
                      height: 75,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      color: state.locale == e.locale
                          ? Colors.blue[50]
                          : Colors.transparent,
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.language,
                              style: TextStyle(
                                  color: state.locale == e.locale
                                      ? Colors.black
                                      : null),
                            ),
                            state.locale == e.locale
                                ? Icon(Icons.check,
                                    color: state.locale == e.locale
                                        ? Colors.black
                                        : null)
                                : SizedBox(),
                          ]),
                    )))
                .toList()),
      ),
    );
  }
}
