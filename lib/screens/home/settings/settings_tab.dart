import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/user.dart';
import 'package:lettutor_app/screens/home/settings/language_setting_screen.dart';
import 'package:lettutor_app/screens/home/settings/password_change_screen.dart';
import 'package:lettutor_app/screens/home/settings/profile_edit_screen.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class SettingsTab extends StatelessWidget {
  final titleStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.hugeTextSize);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Settings', style: titleStyle),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Row(
              children: <Widget>[
                ClipOval(
                  child: Image.asset(
                    User.data.avatar,
                    fit: BoxFit.cover,
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(User.data.name,
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
                    child: Text('Account Settings',
                        style: TextStyle(
                            fontSize: AppSizes.normalTextSize,
                            color: Colors.grey)),
                  ),
                  SizedBox(
                    height: AppSizes.verticalItemSpacing,
                  ),
                  SettingItem(
                    title: 'Edit profile',
                    function: () {
                      Navigator.of(context)
                          .pushNamed(LettutorRoutes.userProfile);
                    },
                  ),
                  SettingItem(
                    title: 'Change password',
                    function: () {
                      Navigator.of(context)
                          .pushNamed(LettutorRoutes.changePassword);
                    },
                  ),
                  SettingItem(
                    title: 'Language',
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
                          'Dark mode',
                          style: TextStyle(
                              fontSize: AppSizes.normalTextSize,
                              fontWeight: FontWeight.normal),
                        ),
                        Switch(
                          value: false,
                          onChanged: (bool value) {},
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
                text: 'Logout',
                function: () {
                  Navigator.pop(context);
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
    return TextButton(
        style: TextButton.styleFrom(
            primary: Colors.black, padding: EdgeInsets.all(0)),
        onPressed: function,
        child: Container(
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
