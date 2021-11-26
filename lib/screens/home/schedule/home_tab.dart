import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/screens/home/schedule/history_screen.dart';
import 'package:lettutor_app/widgets/upcomming_lesson_item.dart';

class HomeTab extends StatelessWidget {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: AppSizes.pagePadding),
            height: 105,
            color: AppTheme.primaryColor,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      Navigator.of(context).pushNamed(LettutorRoutes.history);
                    },
                    child:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Icon(Icons.history),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'History',
                        style: TextStyle(fontSize: AppSizes.normalTextSize),
                      )
                    ]),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Total learned time',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.normalTextSize,
                        color: Colors.white),
                  ),
                ),
                Text('36 hours 12 minutes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.largeTextSize,
                        color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.pagePadding),
            child: Column(
              children: <Widget>[
                UpcommingLessonItem(
                  tutor: Tutor.data,
                  startMeeting: DateTime.now(),
                  endMeeting: DateTime.now(),
                  upcommingLesson: true,
                ),
                SizedBox(height: AppSizes.verticalItemSpacing),
                UpcommingLessonItem(
                    tutor: Tutor.data1,
                    startMeeting: DateTime.now(),
                    endMeeting: DateTime.now()),
                SizedBox(height: AppSizes.verticalItemSpacing),
                UpcommingLessonItem(
                    tutor: Tutor.data2,
                    startMeeting: DateTime.now(),
                    endMeeting: DateTime.now()),
                SizedBox(height: AppSizes.verticalItemSpacing),
                UpcommingLessonItem(
                    tutor: Tutor.data3,
                    startMeeting: DateTime.now(),
                    endMeeting: DateTime.now()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
