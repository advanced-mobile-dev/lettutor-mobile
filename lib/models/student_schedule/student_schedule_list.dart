import 'package:lettutor_app/models/student_schedule/student_schedule.dart';

class StudentScheduleList {
  final int count;
  final List<StudentSchedule> data;

  StudentScheduleList({
    this.count,
    this.data,
  });

  factory StudentScheduleList.fromJson(dynamic json) {
    List<StudentSchedule> studentScheduleList = <StudentSchedule>[];
    int count = json['count'] as int;
    studentScheduleList = (json['rows'] as List).map((element) {
      StudentSchedule studentSchedule = StudentSchedule.fromJson(element);
      return studentSchedule;
    }).toList();
    return StudentScheduleList(
      count: count,
      data: studentScheduleList,
    );
  }
}
