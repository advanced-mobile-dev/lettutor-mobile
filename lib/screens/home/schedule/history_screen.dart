import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/feedback.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/outline_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).history,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            children: <Widget>[
              HistoryItem(
                tutor: Tutor.data,
              ),
              SizedBox(height: AppSizes.verticalItemSpacing),
              HistoryItem(
                tutor: Tutor.data1,
                feedback: LearnerFeedback(
                    rating: 4.5,
                    comment:
                        'This is an excellent teacher. He is very talented and kind'),
              ),
              SizedBox(height: AppSizes.verticalItemSpacing),
              HistoryItem(
                tutor: Tutor.data2,
                feedback: LearnerFeedback(
                    rating: 4.5,
                    comment:
                        'This is an excellent teacher. He is very talented and kind'),
              ),
              SizedBox(height: AppSizes.verticalItemSpacing),
              HistoryItem(
                tutor: Tutor.data3,
                feedback: LearnerFeedback(
                    rating: 4.5,
                    comment:
                        'This is an excellent teacher. He is very talented and kind'),
              ),
              SizedBox(height: AppSizes.verticalItemSpacing),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final Tutor tutor;
  final LearnerFeedback feedback;
  HistoryItem({@required this.tutor, this.feedback});
  @override
  Widget build(BuildContext context) {
    _buildDataRow({String title, IconData iconData, String content}) {
      final titleStyle = TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.smallTextSize,
          color: Theme.of(context).primaryColor);
      final contentStyle = TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: AppSizes.smallTextSize,
          color: Colors.black);
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            iconData,
            size: 15,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 100,
            child: Text(
              title,
              style: titleStyle,
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: contentStyle,
              textAlign: TextAlign.start,
            ),
          )
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3))
          ]),
      padding: EdgeInsets.all(AppSizes.cardPadding),
      child: Column(
        children: <Widget>[
          Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          LettutorRoutes.tutorProfile,
                          arguments: tutor);
                    },
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            tutor.avatar,
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tutor.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/national_flags/${tutor.countryCode}.png',
                                  height: 15,
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(tutor.countryName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: AppSizes.smallTextSize))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  Container(
                    child: Text('3 days ago',
                        style: TextStyle(
                            fontSize: AppSizes.smallTextSize,
                            color: Colors.grey)),
                    alignment: Alignment.topRight,
                  )
                ],
              )),
          SizedBox(
            height: 10,
          ),
          _buildDataRow(
            title: 'Date',
            iconData: Icons.calendar_today,
            content: '20:00 - 20:25, Monday 11/10/2021',
          ),
          SizedBox(
            height: 10,
          ),
          _buildDataRow(
            title: 'Learned time',
            iconData: Icons.timelapse,
            content: '30 minutes 15 senconds',
          ),
          SizedBox(
            height: 10,
          ),
          feedback != null
              ? _buildDataRow(
                  title: 'Your feedback',
                  iconData: Icons.comment,
                  content:
                      'This is an excellent teacher. He is very talented and kind',
                )
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          feedback == null
              ? Container(
                  alignment: Alignment.bottomRight,
                  child: AppOutlineButton(
                    text: 'Feedback',
                    function: () {},
                    iconData: Icons.comment,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
