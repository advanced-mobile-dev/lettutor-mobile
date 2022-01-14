import 'package:flutter/material.dart';
import 'package:lettutor_app/data/network/apis/course_api_client.dart';
import 'package:lettutor_app/models/course/course_list.dart';
import 'package:lettutor_app/models/filter/course_filter.dart';

class CourseRepository {
  final CourseApiClient courseApiClient;
  CourseRepository({@required this.courseApiClient});

  Future<CourseList> getCourses(
      int perPage, int page, CourseFilter courseFilter) async {
    return await courseApiClient.getCourses(perPage, page, courseFilter.levels,
        courseFilter.categories, courseFilter.keyword);
  }
}
