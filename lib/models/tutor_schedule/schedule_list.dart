import 'package:intl/intl.dart';
import 'package:lettutor_app/models/tutor_schedule/schedule_detail.dart';
import 'package:lettutor_app/models/tutor_schedule/tutor_schedule.dart';
import "package:collection/collection.dart";
import 'package:lettutor_app/utils/date_utils.dart';

class ScheduleList {
  final List<ScheduleDetail> data;
  final Map<String, List<ScheduleDetail>> scheduleDetailMap;

  ScheduleList({this.data, this.scheduleDetailMap});

  factory ScheduleList.fromJson(dynamic json) {
    List<ScheduleDetail> schedules = <ScheduleDetail>[];
    (json['data'] as List).map((element) {
      final tutorSchedule = TutorSchedule.fromJson(element);
      tutorSchedule.scheduleDetails.forEach((detail) {
        if (detail.endPeriod.difference(DateTime.now()).inSeconds > 0)
          schedules.add(detail);
      });
    }).toList();

    final Map<String, List<ScheduleDetail>> map = schedules.groupListsBy(
        (schedule) => MyDateUtils.formatDate(schedule.startPeriod));

    return ScheduleList(data: schedules, scheduleDetailMap: map);
  }
}
