import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/screens/log_in_screen.dart';
import 'package:lettutor_app/screens/sign_up_screen.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String backgroundPath = 'assets/images/background.svg';
    final String imagePath = 'assets/images/illustrator_image_01.svg';
    final Widget background = SvgPicture.asset(backgroundPath);
    final Widget image = SvgPicture.asset(imagePath);

    final ButtonStyle raisedButtonStyle1 = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: AppTheme.mainColor,
      minimumSize: Size(double.infinity, 60),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );

    final ButtonStyle raisedButtonStyle2 = ElevatedButton.styleFrom(
      onPrimary: AppTheme.mainColor,
      primary: Colors.white,
      minimumSize: Size(double.infinity, 60),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              background,
              Padding(
                padding: MediaQuery.of(context).padding,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(children: <Widget>[
                    Text('Let Tutor',
                        style:
                            TextStyle(fontSize: 36, color: AppTheme.mainColor)),
                    image,
                  ]),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  style: raisedButtonStyle1,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ));
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: raisedButtonStyle2,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
