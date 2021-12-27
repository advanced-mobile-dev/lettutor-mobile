import 'package:lettutor_app/models/tutor/tutor.dart';

class UpcommingLessonTmp {
  final int id;
  final Tutor tutor;
  final String date;
  final String time;
  UpcommingLessonTmp(this.id, this.tutor, this.date, this.time);

  static List<UpcommingLessonTmp> sampleData = [
    // UpcommingLessonTmp(1, Tutor.data, '02/12/2021', '17:00 - 19:00'),
    // UpcommingLessonTmp(2, Tutor.data1, '03/12/2021', '20:00 - 21:00'),
  ];
}
