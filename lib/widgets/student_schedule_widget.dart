import 'package:flutter/material.dart';
import 'package:lettutor_app/models/student_schedule/student_schedule.dart';
import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';

class StudentScheduleWidget extends StatelessWidget {
  final StudentSchedule studentSchedule;
  final bool isNearestLesson;
  StudentScheduleWidget(
      {@required this.studentSchedule, this.isNearestLesson = false});
  @override
  Widget build(BuildContext context) {
    final TutorBasicInfo tutorBasicInfo =
        studentSchedule.scheduleDetail.tutorBasicInfo;
    if (tutorBasicInfo == null) return SizedBox();
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      MyDateUtils.getTimeFrame(
                          studentSchedule.scheduleDetail.startPeriod,
                          studentSchedule.scheduleDetail.endPeriod),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    MyDateUtils.formatDate2(
                        studentSchedule.scheduleDetail.startPeriod),
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TutorImageWidget(
                        tutorBasicInfo: tutorBasicInfo,
                        size: 40,
                        showRating: false),
                    studentSchedule.bookingInfo.studentRequest == null
                        ? SizedBox()
                        : Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Your note: ${studentSchedule.bookingInfo.studentRequest}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )),
                  ],
                )),
          ],
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: SubmitButton(
            text: 'Start',
            function: () {},
            width: 100,
            height: 35,
            textColor: Colors.black,
            backgroundColor: Colors.grey[200],
          ),
        )
      ]),
    );
  }
}
