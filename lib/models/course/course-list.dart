import 'package:lettutor_app/models/course/course.dart';

class CourseList {
  final List<Course> courses;

  CourseList({
    this.courses,
  });

  factory CourseList.fromJson(List<dynamic> json) {
    List<Course> courses = <Course>[];
    courses = json.map((course) => Course.fromJson(course)).toList();

    return CourseList(
      courses: courses,
    );
  }
}
