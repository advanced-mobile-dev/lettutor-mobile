import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';

class TutorList {
  final int count;
  final List<Tutor> data;

  TutorList({
    this.count,
    this.data,
  });

  factory TutorList.fromJson(dynamic json, String keyword) {
    List<Tutor> tmpTutors = <Tutor>[];
    List<Tutor> tutors = <Tutor>[];
    int count = json['count'] as int;
    tmpTutors = (json['rows'] as List).map((element) {
      Tutor tutor = Tutor.fromJson(element);
      TutorBasicInfo tutorBasicInfo = TutorBasicInfo.fromJson(element);
      tutor.tutorBasicInfo = tutorBasicInfo;
      return tutor;
    }).toList();
    tmpTutors.forEach((element) {
      if (element.tutorBasicInfo.name
          .toLowerCase()
          .contains(keyword.toLowerCase())) tutors.add(element);
    });
    return TutorList(
      count: count,
      data: tutors,
    );
  }
}
