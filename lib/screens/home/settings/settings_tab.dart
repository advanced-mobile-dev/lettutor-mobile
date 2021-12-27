import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/providers/app-settings-provider.dart';
import 'package:lettutor_app/providers/user-provider.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: AppSizes.hugeTextSize);
    User user = context.read<UserProvider>().user;
    print(context.read<UserProvider>());
    final appSettingsProvider = context.watch<AppSettingsProvider>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(AppLocalizations.of(context).settings, style: titleStyle),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Row(
              children: <Widget>[
                ClipOval(
                  // child: user.avatar == null
                  child: 1 == 1
                      ? Icon(Icons.account_circle_outlined)
                      : Image.network(
                          user.avatar,
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                        ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(user.name,
                    style: TextStyle(
                        fontSize: AppSizes.normalTextSize,
                        fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Divider(
              thickness: 1.5,
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: AppSizes.verticalItemSpacing,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(AppLocalizations.of(context).accountSettings,
                        style: TextStyle(
                            fontSize: AppSizes.normalTextSize,
                            color: Colors.grey)),
                  ),
                  SizedBox(
                    height: AppSizes.verticalItemSpacing,
                  ),
                  SettingItem(
                    title: AppLocalizations.of(context).editProfile,
                    function: () {
                      Navigator.of(context)
                          .pushNamed(LettutorRoutes.userProfile);
                    },
                  ),
                  SettingItem(
                    title: AppLocalizations.of(context).changePassword,
                    function: () {
                      Navigator.of(context)
                          .pushNamed(LettutorRoutes.changePassword);
                    },
                  ),
                  SettingItem(
                    title: AppLocalizations.of(context).language,
                    function: () {
                      Navigator.of(context)
                          .pushNamed(LettutorRoutes.languageSetting);
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
                        Switch(
                          value: appSettingsProvider.isDarkTheme,
                          onChanged: (bool value) {
                            appSettingsProvider.setIsDarkTheme(value);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            SubmitButton(
                text: AppLocalizations.of(context).logout,
                function: () {
                  context.read<UserProvider>().logout();
                  // Provider.of<UserProvider>(context, listen: false)
                  //     .setUser(null);
                  Navigator.pushReplacementNamed(context, LettutorRoutes.start);
                }),
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final Function() function;
  final String title;
  SettingItem({@required this.function, @required this.title});

  final TextStyle textStyle = TextStyle(
      fontSize: AppSizes.normalTextSize, fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: function,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: textStyle,
              ),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ));
  }
}
