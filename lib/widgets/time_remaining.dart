import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lettutor_app/utils/date_utils.dart';

class TimeRemaining extends StatefulWidget {
  final DateTime time;
  const TimeRemaining(
    this.time, {
    Key key,
  }) : super(key: key);

  @override
  State<TimeRemaining> createState() => _TimeRemainingState();
}

class _TimeRemainingState extends State<TimeRemaining> {
  Timer _timer;
  @override
  void initState() {
    super.initState();
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
      '${MyDateUtils.timeRemaining(widget.time, showSeconds: true)}',
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
