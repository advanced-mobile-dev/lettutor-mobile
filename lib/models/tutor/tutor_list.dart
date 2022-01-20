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
    int count = json['count'] as int;
    List<Tutor> tutors = (json['rows'] as List).map((element) {
      Tutor tutor = Tutor.fromJson(element);
      TutorBasicInfo tutorBasicInfo = TutorBasicInfo.fromJson(element);
      tutor.tutorBasicInfo = tutorBasicInfo;
      return tutor;
    }).toList();
    tutors.sort((Tutor a, Tutor b) => b.tutorBasicInfo
        .calcAvgRating()
        .compareTo(a.tutorBasicInfo.calcAvgRating()));
    return TutorList(
      count: count,
      data: tutors,
    );
  }
}
