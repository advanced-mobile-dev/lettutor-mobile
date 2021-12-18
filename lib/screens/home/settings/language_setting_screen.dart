import 'package:flutter/material.dart';
import 'package:lettutor_app/config/languages.dart';
import 'package:lettutor_app/providers/app-settings-provider.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appSettingsProvider = context.watch<AppSettingsProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).language,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
              children: supportedLanguages
                  .map((e) => GestureDetector(
                        onTap: () {
                          appSettingsProvider.setLanguage(e.locale);
                        },
                        child: Container(
                            height: 75,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            color: appSettingsProvider.locale == e.locale
                                ? Colors.blue[50]
                                : Colors.transparent,
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e.language),
                                  appSettingsProvider.locale == e.locale
                                      ? Icon(Icons.check)
                                      : SizedBox(),
                                ])),
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
