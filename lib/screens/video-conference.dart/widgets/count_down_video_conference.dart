import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lettutor_app/models/student_booking/student_booking.dart';
import 'package:lettutor_app/utils/date_utils.dart';

class CountDownVideoConference extends StatefulWidget {
  final StudentBooking studentBooking;
  const CountDownVideoConference(
    this.studentBooking, {
    Key key,
  }) : super(key: key);

  @override
  State<CountDownVideoConference> createState() =>
      _CountDownVideoConferenceState();
}

class _CountDownVideoConferenceState extends State<CountDownVideoConference> {
  Timer _timer;
  StudentBooking _studentBooking;
  @override
  void initState() {
    super.initState();
    _studentBooking = widget.studentBooking;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
        '${MyDateUtils.countDown(_studentBooking.scheduleDetail.startPeriod, showSeconds: true)}',
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Colors.white));
  }
}
