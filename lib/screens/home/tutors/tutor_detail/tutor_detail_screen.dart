import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/screens/home/tutors/tutor_detail/tutor_description.dart';
import 'package:lettutor_app/screens/home/tutors/tutor_detail/tutor_reviews.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/icons.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class TutorDetail extends StatelessWidget {
  final Tutor tutor;
  TutorDetail({this.tutor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: ApplicationAppBar(
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
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
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tutor.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                                  itemSize: 15,
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
                                  style: TextStyle(fontSize: 14))
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Text(
                  tutor.description,
                ),
              ),
              SubmitButton(
                text: 'Calendar',
                function: () {},
                backgroundColor: Colors.white,
                textColor: AppTheme.mainColor,
                icon: Icon(Icons.calendar_today),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFlatButton(
                        icon: AppIcons.chatIcon,
                        function: () {},
                        title: 'Message'),
                    _buildFlatButton(
                        icon: AppIcons.favoriteIcon,
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
              TutorDescription(),
              TutorReviews()
            ],
          ),
        ),
      ),
    );
  }
}

_buildFlatButton({Widget icon, Function() function, String title}) {
  final ButtonStyle buttonStyle = TextButton.styleFrom(
      primary: AppTheme.mainColor, backgroundColor: Colors.transparent);
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
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14))
        ],
      ));
}
