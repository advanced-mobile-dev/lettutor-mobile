import 'package:lettutor_app/models/config/speciality.dart';

class TutorFilter {
  final List<Speciality> specialities;
  final String keyword;
  TutorFilter({this.specialities, this.keyword = ''});

  TutorFilter copyWith({String keyword, List<Speciality> specialities}) {
    return TutorFilter(
      keyword: keyword ?? this.keyword,
      specialities: specialities ?? this.specialities,
    );
  }
}
