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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SvgPicture.asset(
                Assets.background,
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
                            height: 40, color: Theme.of(context).primaryColor),
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
                                height: 150,
                              ),
                              SubmitButton(
                                  text: 'Login',
                                  function: () {
                                    Navigator.of(context)
                                        .pushNamed(LettutorRoutes.signIn);
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              SubmitButton(
                                  text: 'Sign up',
                                  backgroundColor: Theme.of(context).cardColor,
                                  textColor: (Theme.of(context)
                                              .primaryColorBrightness ==
                                          Brightness.dark)
                                      ? Colors.white60
                                      : AppColors.customGrey,
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
    );
  }
}
