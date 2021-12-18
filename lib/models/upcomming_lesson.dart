import 'package:lettutor_app/models/tutor.dart';

class UpcommingLessonTmp {
  final int id;
  final TutorTmp tutor;
  final String date;
  final String time;
  UpcommingLessonTmp(this.id, this.tutor, this.date, this.time);

  static List<UpcommingLessonTmp> sampleData = [
    UpcommingLessonTmp(1, TutorTmp.data, '02/12/2021', '17:00 - 19:00'),
    UpcommingLessonTmp(2, TutorTmp.data1, '03/12/2021', '20:00 - 21:00'),
  ];
}
