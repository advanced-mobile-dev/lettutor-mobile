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
  final bool showLoading;
  CoursesRefreshEvent({this.showLoading = false});

  @override
  List<Object> get props => [];
}

class ApplyCourseFilterEvent extends CoursesEvent {
  final CourseFilter courseFilter;
  ApplyCourseFilterEvent({this.courseFilter});
  @override
  List<Object> get props => [];
}
