import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/widgets/icons.dart';
import 'package:lettutor_app/widgets/upcomming_lesson_item.dart';

class ScheduleTab extends StatelessWidget {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: AppSizes.pagePadding),
              child: Column(
                children: <Widget>[
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppIcons.appLogo,
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(LettutorRoutes.history);
                        },
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.history, color: Colors.black),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'History',
                                style: TextStyle(
                                    fontSize: AppSizes.normalTextSize,
                                    color: Colors.black),
                              )
                            ]),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Row(children: [
                        Icon(
                          Icons.timer,
                          color: AppTheme.primaryColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Total learned time: 36 hours 12 minutes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.normalTextSize,
                              color: AppTheme.primaryColor),
                        ),
                      ])),
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
                  SizedBox(height: AppSizes.verticalItemSpacing * 2),
                  UpcommingLessonItem(
                      tutor: Tutor.data1,
                      startMeeting: DateTime.now(),
                      endMeeting: DateTime.now()),
                  SizedBox(height: AppSizes.verticalItemSpacing * 2),
                  UpcommingLessonItem(
                      tutor: Tutor.data2,
                      startMeeting: DateTime.now(),
                      endMeeting: DateTime.now()),
                  SizedBox(height: AppSizes.verticalItemSpacing * 2),
                  UpcommingLessonItem(
                      tutor: Tutor.data3,
                      startMeeting: DateTime.now(),
                      endMeeting: DateTime.now()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
