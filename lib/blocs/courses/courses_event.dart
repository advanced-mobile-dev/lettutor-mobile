part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {}

class CoursesFetchEvent extends CoursesEvent {
  CoursesFetchEvent();

  @override
  List<Object> get props => [];
}

class CoursesLoadMoreEvent extends CoursesEvent {
  CoursesLoadMoreEvent();

  @override
  List<Object> get props => [];
}

class CoursesRefreshEvent extends CoursesEvent {
  CoursesRefreshEvent();

  @override
  List<Object> get props => [];
}

class ApplyCoursesFilterEvent extends CoursesEvent {
  final CourseFilter courseFilter;
  ApplyCoursesFilterEvent({this.courseFilter});
  @override
  List<Object> get props => [];
}
