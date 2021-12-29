import 'package:flutter/material.dart';
import 'package:lettutor_app/data/repository.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';

class TutorProvider extends ChangeNotifier {
  List<Tutor> _tutorList = <Tutor>[];
  bool _loading = false;

  List<Tutor> get tutorList => _tutorList;
  bool get loading => _loading;

  // searchTutors({int page, String speciality}) async {
  //   _loading = true;
  //   notifyListeners();
  //   try {
  //     final List<Tutor> tmpTutorList =
  //         await Repository.getTutors(12, 1, ['$speciality']);
  //     print(tmpTutorList.length);
  //     _tutorList.clear();
  //     _tutorList.addAll(tmpTutorList);
  //   } catch (exception, stackStrace) {
  //     print(exception);
  //     print(stackStrace);
  //   } finally {
  //     _loading = false;
  //   }
  //   notifyListeners();
  // }
}
