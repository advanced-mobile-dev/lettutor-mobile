import 'package:lettutor_app/models/speciality.dart';

class TutorFilter {
  final List<Speciality> specialities;
  final String keyword;
  TutorFilter({this.specialities, this.keyword = ''});
}
