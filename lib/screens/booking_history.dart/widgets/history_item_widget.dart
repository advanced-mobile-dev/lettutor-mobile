import 'package:flutter/material.dart';

import 'package:lettutor_app/models/booking/booking.dart';
import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/outline_button.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';

class HistoryItem extends StatelessWidget {
  final Booking studentBooking;
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
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 75,
              child: Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Expanded(
              child: Text(
                content,
                style: Theme.of(context).textTheme.subtitle2,
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
      color: Theme.of(context).cardColor,
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
                        style: Theme.of(context).textTheme.caption),
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
