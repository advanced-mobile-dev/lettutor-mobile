import 'package:lettutor_app/models/student_booking/student_booking.dart';

class StudentBookingList {
  final int count;
  final List<StudentBooking> data;

  StudentBookingList({
    this.count,
    this.data,
  });

  factory StudentBookingList.fromJson(dynamic json) {
    List<StudentBooking> studentScheduleList = <StudentBooking>[];
    int count = json['count'] as int;
    studentScheduleList = (json['rows'] as List).map((element) {
      StudentBooking studentSchedule = StudentBooking.fromJson(element);
      return studentSchedule;
    }).toList();
    return StudentBookingList(
      count: count,
      data: studentScheduleList,
    );
  }
}
