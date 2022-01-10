import 'course.dart';

class CourseList {
  final int count;
  final List<Course> data;

  CourseList({
    this.count,
    this.data,
  });

  factory CourseList.fromJson(dynamic json) {
    List<Course> courses = <Course>[];
    int count = json['count'] as int;
    courses = (json['rows'] as List).map((element) {
      Course course = Course.fromJson(element);
      course.topics.sort((a, b) => a.orderCourse.compareTo(b.orderCourse));
      return course;
    }).toList();
    return CourseList(
      count: count,
      data: courses,
    );
  }
}
