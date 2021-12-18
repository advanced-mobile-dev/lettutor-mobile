import 'package:lettutor_app/models/tutor/tutor.dart';

class TutorList {
  final List<Tutor> tutors;

  TutorList({
    this.tutors,
  });

  factory TutorList.fromJson(List<dynamic> json) {
    List<Tutor> tutors = <Tutor>[];
    tutors = json.map((tutor) => Tutor.fromJson(tutor)).toList();

    return TutorList(
      tutors: tutors,
    );
  }
}
