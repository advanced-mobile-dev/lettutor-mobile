import 'package:flutter/material.dart';
import 'package:lettutor_app/models/booking/booking.dart';
import 'package:lettutor_app/screens/dash_board/tabs/home/widgets/booking_item_widget.dart';
import 'package:lettutor_app/widgets/time_remaining.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpcommingClassWidget extends StatelessWidget {
  final Booking studentBooking;
  UpcommingClassWidget(this.studentBooking);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            // color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${AppLocalizations.of(context).upcommingLesson}',
              // 'Upcomming lesson',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TimeRemaining(studentBooking.scheduleDetail.startPeriod),
          ],
        ),
      ),
      BookingItemWidget(
        studentBooking: studentBooking,
      ),
    ]);
  }
}
