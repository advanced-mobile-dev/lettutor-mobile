import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/models/upcomming_lesson.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingScreen extends StatelessWidget {
  final Tutor tutor;
  final String time;
  BookingScreen({@required this.tutor, @required this.time});

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = TextStyle(
        fontSize: AppSizes.normalTextSize, fontWeight: FontWeight.bold);
    final contentTextStyle = TextStyle(
        // color: AppTheme.textColor,
        fontSize: AppSizes.normalTextSize);
    return Scaffold(
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).bookAClass,
      ),
      body: Container(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        fontSize: AppSizes.normalTextSize))
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
                  AppLocalizations.of(context).bookingTime,
                  style: titleTextStyle,
                ),
                SizedBox(
                  height: AppSizes.verticalItemSpacing,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    '15:00 - 17:00, Monday 07/12/2021',
                    style: contentTextStyle,
                  ),
                ),
                SizedBox(
                  height: AppSizes.verticalItemSpacing,
                ),
                Text(AppLocalizations.of(context).balance,
                    style: titleTextStyle),
                SizedBox(
                  height: AppSizes.verticalItemSpacing,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    '17 ${AppLocalizations.of(context).lessonsLeft}',
                    style: contentTextStyle,
                  ),
                ),
                SizedBox(
                  height: AppSizes.verticalItemSpacing,
                ),
                Text(AppLocalizations.of(context).price, style: titleTextStyle),
                SizedBox(
                  height: AppSizes.verticalItemSpacing,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    '1 ${AppLocalizations.of(context).lesson}',
                    style: contentTextStyle,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SubmitButton(
                  text: AppLocalizations.of(context).book.toUpperCase(),
                  function: () {
                    UpcommingLesson.sampleData.add(
                        UpcommingLesson(3, tutor, '21/12/2021', '15:00 17:00'));
                    Navigator.popUntil(
                        context, ModalRoute.withName(LettutorRoutes.home));
                  },
                ),
                SizedBox(
                  height: AppSizes.verticalItemSpacing,
                ),
                SubmitButton(
                  text: AppLocalizations.of(context).cancel.toUpperCase(),
                  function: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.white,
                  textColor: Theme.of(context).primaryColor,
                ),
              ])),
    );
  }
}

class BookingScreenArguments {
  final Tutor tutor;
  final String time;

  BookingScreenArguments({this.tutor, this.time});
}
