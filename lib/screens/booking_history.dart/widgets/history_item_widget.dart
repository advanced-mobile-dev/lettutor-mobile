import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/student_booking/student_booking.dart';
import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/outline_button.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';

class HistoryItem extends StatelessWidget {
  final StudentBooking studentBooking;
  HistoryItem({@required this.studentBooking});
  @override
  Widget build(BuildContext context) {
    _buildDataRow({String title, IconData iconData, String content}) {
      return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
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
              width: 75,
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.smallTextSize,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Expanded(
              child: Text(
                content,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: AppSizes.smallTextSize,
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
      );
    }

    TutorBasicInfo tutorBasicInfo =
        studentBooking.scheduleDetail.tutorBasicInfo;

    String feedback = studentBooking.bookingInfo.tutorReview;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3))
          ]),
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TutorImageWidget(
                        tutorBasicInfo: tutorBasicInfo,
                        height: 50,
                        showRating: false),
                  ),
                  Container(
                    child: Text(
                        '${MyDateUtils.getCommentTime(studentBooking.scheduleDetail.endPeriod)}',
                        style: TextStyle(
                            fontSize: AppSizes.smallTextSize,
                            color: Colors.grey)),
                    alignment: Alignment.topRight,
                  )
                ],
              )),
          _buildDataRow(
            title: 'Date',
            iconData: Icons.calendar_today,
            content:
                '${MyDateUtils.getBookingTime(studentBooking.scheduleDetail)}',
          ),
          _buildDataRow(
            title: 'Feedback',
            iconData: Icons.chat,
            content: '${feedback ?? ''}',
          ),
          studentBooking.bookingInfo.scoreByTutor != null
              ? _buildDataRow(
                  title: 'Mark',
                  iconData: Icons.reviews_outlined,
                  content: '${studentBooking.bookingInfo.scoreByTutor}',
                )
              : SizedBox(),
          studentBooking.bookingInfo.recordUrl != null
              ? Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.bottomRight,
                  child: CustomTextButton(
                      text: 'Record',
                      function: () {},
                      iconData: Icons.video_call,
                      color: Theme.of(context).primaryColor),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
