import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/student_booking/student_booking_bloc.dart';
import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/models/booking/booking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingItemWidget extends StatelessWidget {
  final Booking studentBooking;
  final bool isNearestLesson;
  BookingItemWidget(
      {@required this.studentBooking, this.isNearestLesson = false});
  @override
  Widget build(BuildContext context) {
    final TutorBasicInfo tutorBasicInfo =
        studentBooking.scheduleDetail.tutorBasicInfo;
    if (tutorBasicInfo == null) return SizedBox();
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, LettutorRoutes.meeting,
            arguments: studentBooking);
        context.read<StudentBookingBloc>().add(StudentBookingFetchDataEvent());
      },
      child: Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
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
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        MyDateUtils.formatDate2(
                            studentBooking.scheduleDetail.startPeriod),
                        style: Theme.of(context).textTheme.bodyText2),
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
                          height: 50,
                          showRating: false),
                      studentBooking.bookingInfo.studentRequest == null
                          ? SizedBox()
                          : Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${AppLocalizations.of(context).note}: ${studentBooking.bookingInfo.studentRequest}',
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
                    text: '${AppLocalizations.of(context).start}',
                    function: () async {
                      await Navigator.pushNamed(context, LettutorRoutes.meeting,
                          arguments: studentBooking);
                      context
                          .read<StudentBookingBloc>()
                          .add(StudentBookingFetchDataEvent());
                    },
                    width: 100,
                    height: 35,
                  ),
                )
              : SizedBox()
        ]),
      ),
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
