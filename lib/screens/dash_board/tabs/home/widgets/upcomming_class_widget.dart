import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lettutor_app/models/student_booking/student_booking.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/screens/dash_board/tabs/home/widgets/booking_item_widget.dart';

class UpcommingClassWidget extends StatelessWidget {
  final StudentBooking studentBooking;
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
              'Upcomming class',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            CountDownUpcommingClass(studentBooking),
          ],
        ),
      ),
      BookingItemWidget(
        studentBooking: studentBooking,
      ),
    ]);
  }
}

class CountDownUpcommingClass extends StatefulWidget {
  final StudentBooking studentBooking;
  const CountDownUpcommingClass(
    this.studentBooking, {
    Key key,
  }) : super(key: key);

  @override
  State<CountDownUpcommingClass> createState() =>
      _CountDownUpcommingClassState();
}

class _CountDownUpcommingClassState extends State<CountDownUpcommingClass> {
  Timer _timer;
  StudentBooking _studentBooking;
  @override
  void initState() {
    super.initState();
    _studentBooking = widget.studentBooking;
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${MyDateUtils.countDown(_studentBooking.scheduleDetail.startPeriod)}',
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
