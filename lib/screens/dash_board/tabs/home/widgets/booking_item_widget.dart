import 'package:flutter/material.dart';
import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/models/student_booking/student_booking.dart';
import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';

class BookingItemWidget extends StatelessWidget {
  final StudentBooking studentBooking;
  final bool isNearestLesson;
  BookingItemWidget(
      {@required this.studentBooking, this.isNearestLesson = false});
  @override
  Widget build(BuildContext context) {
    final TutorBasicInfo tutorBasicInfo =
        studentBooking.scheduleDetail.tutorBasicInfo;
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
                          studentBooking.scheduleDetail.startPeriod,
                          studentBooking.scheduleDetail.endPeriod),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    MyDateUtils.formatDate2(
                        studentBooking.scheduleDetail.startPeriod),
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
                        height: 40,
                        showRating: false),
                    studentBooking.bookingInfo.studentRequest == null
                        ? SizedBox()
                        : Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Your note: ${studentBooking.bookingInfo.studentRequest}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )),
                  ],
                )),
          ],
        ),
        _isShowStartButton()
            ? Container(
                alignment: Alignment.bottomRight,
                child: SubmitButton(
                  text: 'Start',
                  function: () {
                    Navigator.pushNamed(context, LettutorRoutes.videoConference,
                        arguments: studentBooking);
                  },
                  width: 100,
                  height: 35,
                  textColor: Colors.black,
                  backgroundColor: Colors.grey[200],
                ),
              )
            : SizedBox()
      ]),
    );
  }

  _isShowStartButton() {
    if (studentBooking.scheduleDetail.startPeriod
            .difference(DateTime.now())
            .inMinutes <=
        120) return true;
    return false;
  }
}
