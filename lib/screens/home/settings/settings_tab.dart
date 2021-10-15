import 'package:flutter/material.dart';
import 'package:lettutor_app/models/user.dart';
import 'package:lettutor_app/screens/home/settings/language_setting_screen.dart';
import 'package:lettutor_app/screens/home/settings/password_change_screen.dart';
import 'package:lettutor_app/screens/home/settings/profile_edit_screen.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class SettingsTab extends StatelessWidget {
  final titleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 36);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text('Settings', style: titleStyle),
          ),
          Container(
              child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                child: Row(
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
                            fontSize: 18, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Divider(
                thickness: 1.5,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 30, top: 15, bottom: 10),
                      child: Text('Account Settings',
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ),
                    SettingItem(
                      title: 'Edit profile',
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileEditScreen()));
                      },
                    ),
                    SettingItem(
                      title: 'Change password',
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PasswordChangeScreen()));
                      },
                    ),
                    SettingItem(
                      title: 'Language',
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LanguageSettingScreen()));
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 30, right: 10, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Dark mode',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: SubmitButton(text: 'Logout', function: () {}),
              )
            ],
          )),
        ],
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final Function() function;
  final String title;
  SettingItem({@required this.function, @required this.title});

  final TextStyle textStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            primary: Colors.black, padding: EdgeInsets.all(0)),
        onPressed: function,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
