import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/screens/tutor_profile/widgets/tutor_intro_video.dart';
import 'package:lettutor_app/utils/string_utils.dart';

import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';

import 'widgets/tutor-info.dart';
import 'widgets/tutor_reviews.dart';

class TutorProfile extends StatelessWidget {
  final Tutor tutor;
  TutorProfile({this.tutor});

  @override
  Widget build(BuildContext context) {
    _buildFlatButton({Widget icon, Function() function, String title}) {
      final ButtonStyle buttonStyle = TextButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent);
      return TextButton(
          onPressed: function,
          style: buttonStyle,
          child: Column(
            children: <Widget>[
              icon,
              SizedBox(
                height: 4,
              ),
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: AppSizes.normalTextSize))
            ],
          ));
    }

    return Scaffold(
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).profile,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            children: <Widget>[
              TutorImageWidget(
                  tutorBasicInfo: tutor.tutorBasicInfo,
                  size: 100,
                  showRating: true),
              SizedBox(
                height: AppSizes.verticalItemSpacing,
              ),
              Text(
                tutor.bio,
              ),
              SizedBox(
                height: AppSizes.verticalItemSpacing,
              ),
              SubmitButton(
                text: AppLocalizations.of(context).calendar,
                backgroundColor: Colors.white,
                function: () {
                  print(tutor.id);
                  Navigator.of(context).pushNamed(LettutorRoutes.tutorSchedule,
                      arguments: tutor);
                },
                textColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.calendar_today),
              ),
              SizedBox(
                height: AppSizes.verticalItemSpacing,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFlatButton(
                        icon: Badge(
                          badgeColor: Colors.redAccent,
                          badgeContent: Text(
                            '1',
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Icon(Icons.video_library_outlined),
                        ),
                        function: () {
                          showModalBottomSheet(
                            isScrollControlled: false,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => TutorIntroVideo(
                                tutor.tutorBasicInfo.name, tutor.video),
                          );
                        },
                        title: AppLocalizations.of(context).introVideo),
                    _buildFlatButton(
                        icon: SvgPicture.asset('assets/icons/favorite.svg',
                            color: Theme.of(context).primaryColor),
                        function: () {},
                        title: AppLocalizations.of(context).favorite),
                    _buildFlatButton(
                        icon: Icon(
                          Icons.report,
                          size: 20,
                        ),
                        function: () {},
                        title: AppLocalizations.of(context).report),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                height: 10,
              ),
              SizedBox(
                height: AppSizes.verticalItemSpacing,
              ),
              TutorInfo(),
              TutorReviews(tutor.tutorBasicInfo.feedbacks)
            ],
          ),
        ),
      ),
    );
  }
}
