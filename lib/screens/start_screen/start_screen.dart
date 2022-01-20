import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor_app/constants/assets.dart';

import 'package:lettutor_app/constants/colors.dart';
import 'package:lettutor_app/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                SvgPicture.asset(
                  Assets.background,
                  width: width,
                ),
                Column(
                  children: [
                    Padding(
                      padding: MediaQuery.of(context).padding,
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 7,
                          ),
                          SvgPicture.asset(Assets.logo,
                              height: 40,
                              color: Theme.of(context).primaryColor),
                          SizedBox(
                            height: 20,
                          ),
                          SvgPicture.asset(
                            Assets.illustrator_image,
                            height: 150,
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 125,
                                ),
                                SubmitButton(
                                    text:
                                        '${AppLocalizations.of(context).login}',
                                    function: () {
                                      Navigator.of(context)
                                          .pushNamed(LettutorRoutes.signIn);
                                    }),
                                SizedBox(
                                  height: 20,
                                ),
                                SubmitButton(
                                    text:
                                        '${AppLocalizations.of(context).signUp}',
                                    backgroundColor: AppColors.customGrey,
                                    textColor: (Theme.of(context)
                                                .primaryColorBrightness ==
                                            Brightness.dark)
                                        ? Colors.white60
                                        : Colors.white,
                                    function: () {
                                      Navigator.of(context)
                                          .pushNamed(LettutorRoutes.signUp);
                                    }),
                              ],
                            ),
                          )
                        ]),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
