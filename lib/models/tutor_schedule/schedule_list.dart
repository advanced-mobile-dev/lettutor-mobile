import 'package:lettutor_app/models/tutor_schedule/date_schedule.dart';
import 'package:lettutor_app/models/tutor_schedule/schedule_detail.dart';
import 'package:lettutor_app/models/tutor_schedule/tutor_schedule.dart';
import "package:collection/collection.dart";
import 'package:lettutor_app/utils/date_utils.dart';

class ScheduleList {
  final List<ScheduleDetail> data;
  final List<DateSchedule> dateSchedules;

  ScheduleList({this.data, this.dateSchedules});

  factory ScheduleList.fromJson(dynamic json) {
    List<ScheduleDetail> schedules = <ScheduleDetail>[];
    (json['data'] as List).map((element) {
      final tutorSchedule = TutorSchedule.fromJson(element);

      tutorSchedule.scheduleDetails.forEach((detail) {
        if (detail.startPeriod.difference(DateTime.now()).inSeconds > 0) {
          schedules.add(detail);
        }
      });
    }).toList();
    Map<String, List<ScheduleDetail>> map = schedules.groupListsBy(
        (schedule) => MyDateUtils.formatDate(schedule.startPeriod));
    List<DateSchedule> dateSchedules =
        map.entries.map((e) => DateSchedule(e.key, e.value)).toList();

    dateSchedules.sort((a, b) {
      return MyDateUtils.formatStringToDate(a.date)
                  .difference(MyDateUtils.formatStringToDate(b.date))
                  .inDays >
              0
          ? 1
          : -1;
    });
    dateSchedules.forEach((e) {
      e.schedules.sort((a, b) {
        return a.startPeriod.difference(b.startPeriod).inSeconds > 0 ? 1 : -1;
      });
    });

    return ScheduleList(data: schedules, dateSchedules: dateSchedules);
  }
}
