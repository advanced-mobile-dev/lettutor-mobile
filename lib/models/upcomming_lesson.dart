import 'package:lettutor_app/models/tutor.dart';

class UpcommingLesson {
  final int id;
  final Tutor tutor;
  final String date;
  final String time;
  UpcommingLesson(this.id, this.tutor, this.date, this.time);

  static List<UpcommingLesson> sampleData = [
    UpcommingLesson(1, Tutor.data, '02/12/2021', '17:00 - 19:00'),
    UpcommingLesson(2, Tutor.data1, '03/12/2021', '20:00 - 21:00'),
  ];
}
