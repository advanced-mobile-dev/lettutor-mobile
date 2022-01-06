import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/student_booking/student_booking.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/student_schedule_widget.dart';

class UpcommingClassWidget extends StatelessWidget {
  final StudentBooking studentSchedule;
  UpcommingClassWidget(this.studentSchedule);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Upcomming class',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.normalTextSize),
            ),
            CountDownUpcommingClass(studentSchedule),
          ],
        ),
      ),
      StudentBookingWidget(
        studentSchedule: studentSchedule,
      ),
    ]);
  }
}

class CountDownUpcommingClass extends StatefulWidget {
  final StudentBooking studentSchedule;
  const CountDownUpcommingClass(
    this.studentSchedule, {
    Key key,
  }) : super(key: key);

  @override
  State<CountDownUpcommingClass> createState() =>
      _CountDownUpcommingClassState();
}

class _CountDownUpcommingClassState extends State<CountDownUpcommingClass> {
  Timer _timer;
  StudentBooking _studentSchedule;
  @override
  void initState() {
    super.initState();
    _studentSchedule = widget.studentSchedule;
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
        '${MyDateUtils.countDown(_studentSchedule.scheduleDetail.startPeriod)}',
        style:
            TextStyle(color: Colors.black, fontSize: AppSizes.normalTextSize));
  }
}
