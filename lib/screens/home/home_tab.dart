import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/widgets/upcomming_lesson_item.dart';

class HomeTab extends StatelessWidget {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
  );

  final double _horizontalPadding = 20;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 105,
            color: AppTheme.mainColor,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: flatButtonStyle,
                    onPressed: () => {},
                    child:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Icon(Icons.history),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'History',
                        style: TextStyle(fontSize: 14),
                      )
                    ]),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: _horizontalPadding),
                  child: Text(
                    'Total learned time',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('36 hours 12 minutes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding, vertical: 15),
            child: Column(
              children: <Widget>[
                UpcommingLessonItem(
                  tutor: Tutor.data,
                  startMeeting: DateTime.now(),
                  endMeeting: DateTime.now(),
                  upcommingLesson: true,
                ),
                SizedBox(
                  height: 20,
                ),
                UpcommingLessonItem(
                    tutor: Tutor.data1,
                    startMeeting: DateTime.now(),
                    endMeeting: DateTime.now()),
                SizedBox(
                  height: 20,
                ),
                UpcommingLessonItem(
                    tutor: Tutor.data2,
                    startMeeting: DateTime.now(),
                    endMeeting: DateTime.now()),
                SizedBox(
                  height: 20,
                ),
                UpcommingLessonItem(
                    tutor: Tutor.data3,
                    startMeeting: DateTime.now(),
                    endMeeting: DateTime.now()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
