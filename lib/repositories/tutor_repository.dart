import 'package:flutter/material.dart';
import 'package:lettutor_app/data/network/apis/tutor_api_client.dart';
import 'package:lettutor_app/models/filter/tutor_filter.dart';
import 'package:lettutor_app/models/schedule/tutor_schedule_list.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/tutor/tutor_list.dart';

class TutorRepository {
  final TutorApiClient tutorApiClient;
  TutorRepository({@required this.tutorApiClient});

  Future<TutorList> getTutors(
      int perPage, int page, TutorFilter tutorFilter) async {
    final List<String> specialties =
        tutorFilter.specialities.map((e) => e.code).toList();
    final TutorList tutorList = await tutorApiClient.getTutors(
        perPage, page, specialties, tutorFilter.keyword);
    return tutorList;
  }

  Future<Tutor> getTutor(String id) async {
    return await tutorApiClient.getTutorById(id);
  }

  Future<TutorScheduleList> fetchTutorSchedules(String tutorId) async {
    return await tutorApiClient.fetchTutorSchedules(tutorId);
  }
}
