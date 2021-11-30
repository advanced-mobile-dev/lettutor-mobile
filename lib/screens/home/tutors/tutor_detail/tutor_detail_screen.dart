import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/screens/home/tutors/tutor_detail/tutor_description.dart';
import 'package:lettutor_app/screens/home/tutors/tutor_detail/tutor_reviews.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class TutorDetail extends StatelessWidget {
  final Tutor tutor;
  TutorDetail({this.tutor});

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
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            children: <Widget>[
              Container(
                  height: 110,
                  child: Row(
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          tutor.avatar,
                          width: 100.0,
                        ),
                      ),
                      SizedBox(
                        width: AppSizes.horizontalItemSpacing,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tutor.name,
                            style: TextStyle(
                                fontSize: AppSizes.normalTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                '${tutor.rating}',
                                style: TextStyle(color: Colors.amber),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 90,
                                child: RatingBar.builder(
                                  initialRating: tutor.rating,
                                  ignoreGestures: true,
                                  itemSize: AppSizes.normalTextSize,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                              Text(
                                '(11)',
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/national_flags/${tutor.countryCode}.png',
                                height: 25,
                                width: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(tutor.countryName,
                                  style: TextStyle(
                                    fontSize: AppSizes.normalTextSize,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: AppSizes.verticalItemSpacing,
              ),
              Text(
                tutor.description,
              ),
              SizedBox(
                height: AppSizes.verticalItemSpacing,
              ),
              SubmitButton(
                text: 'Calendar',
                backgroundColor: Colors.white,
                function: () {
                  Navigator.of(context).pushNamed(LettutorRoutes.tutorCalendar,
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
                        icon: Icon(Icons.video_library_outlined),
                        function: () {},
                        title: 'Intro video'),
                    // _buildFlatButton(
                    //     icon: AppIcons.chatIcon,
                    //     function: () {},
                    //     title: 'Message'),
                    _buildFlatButton(
                        icon: SvgPicture.asset('assets/icons/favorite.svg',
                            color: Theme.of(context).primaryColor),
                        function: () {},
                        title: 'Favorite'),
                    _buildFlatButton(
                        icon: Icon(
                          Icons.report,
                          size: 20,
                        ),
                        function: () {},
                        title: 'Report'),
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
              TutorDescription(),
              TutorReviews()
            ],
          ),
        ),
      ),
    );
  }
}
