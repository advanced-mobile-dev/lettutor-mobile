import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';

class TutorList {
  final int count;
  final List<Tutor> data;

  TutorList({
    this.count,
    this.data,
  });

  factory TutorList.fromJson(dynamic json) {
    List<Tutor> tutors = <Tutor>[];
    int count = json['count'] as int;
    tutors = (json['rows'] as List).map((element) {
      Tutor tutor = Tutor.fromJson(element);
      TutorBasicInfo tutorBasicInfo = TutorBasicInfo.fromJson(element);
      tutor.tutorBasicInfo = tutorBasicInfo;
      return tutor;
    }).toList();
    return TutorList(
      count: count,
      data: tutors,
    );
  }
}
