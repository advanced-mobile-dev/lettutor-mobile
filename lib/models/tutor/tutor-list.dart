import 'package:lettutor_app/models/tutor/tutor-basic-info.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';

class TutorList {
  final List<Tutor> tutorList;

  TutorList({
    this.tutorList,
  });

  factory TutorList.fromJson(dynamic json) {
    print(json);
    List<Tutor> tutors = <Tutor>[];
    tutors = (json['rows'] as List).map((element) {
      Tutor tutor = Tutor.fromJson(element);
      TutorBasicInfo tutorBasicInfo = TutorBasicInfo.fromJson(element);
      tutor.tutorBasicInfo = tutorBasicInfo;
      return tutor;
    }).toList();

    return TutorList(
      tutorList: tutors,
    );
  }
}
