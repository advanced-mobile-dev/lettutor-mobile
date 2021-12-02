import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String _backgroundPath = 'assets/images/background.svg';
    final Widget _background = SvgPicture.asset(
      _backgroundPath,
    );
    final String _imagePath = 'assets/images/illustrator_image_01.svg';
    final Widget _image = SvgPicture.asset(
      _imagePath,
      width: 175,
    );
    final String _logoPath = 'assets/icons/logo.svg';
    final Widget _logo = SvgPicture.asset(_logoPath,
        height: 40, color: Theme.of(context).primaryColor);

    final ButtonStyle raisedButtonStyle1 = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      // primary: Theme.of(context).primaryColor,
      minimumSize: Size(double.infinity, 60),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );

    final ButtonStyle raisedButtonStyle2 = ElevatedButton.styleFrom(
      onPrimary: Theme.of(context).primaryColor,
      primary: Colors.white,
      minimumSize: Size(double.infinity, 60),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _background,
              Padding(
                padding: MediaQuery.of(context).padding,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 7,
                    ),
                    _logo,
                    SizedBox(
                      height: 12,
                    ),
                    _image,
                  ]),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(AppSizes.pagePadding),
            child: Column(
              children: [
                ElevatedButton(
                  style: raisedButtonStyle1,
                  onPressed: () {
                    Navigator.of(context).pushNamed(LettutorRoutes.signIn);
                  },
                  child: Text(
                    AppLocalizations.of(context).login,
                    style: TextStyle(fontSize: AppSizes.largeTextSize),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: raisedButtonStyle2,
                  onPressed: () {
                    Navigator.of(context).pushNamed(LettutorRoutes.signUp);
                  },
                  child: Text(
                    AppLocalizations.of(context).signUp,
                    style: TextStyle(fontSize: AppSizes.largeTextSize),
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
