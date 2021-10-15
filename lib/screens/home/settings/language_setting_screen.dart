import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/widgets/app_bar.dart';

class LanguageSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle textButtonStyle = TextButton.styleFrom(
        primary: Colors.black,
        padding: EdgeInsets.all(15),
        textStyle: TextStyle(fontSize: 16));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.backgroundColor,
      appBar: ApplicationAppBar(
        title: 'Change password',
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              TextButton(
                  style: textButtonStyle,
                  onPressed: () {},
                  child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Text('Vietnamese'))),
              Divider(
                height: 0,
              ),
              TextButton(
                  style: textButtonStyle,
                  onPressed: () {},
                  child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Text('English'))),
              Divider(
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
