part of 'courses_bloc.dart';

enum CoursesStatus { success, loadingMore, failure }

abstract class CoursesState extends Equatable {
  List<Object> get props => [];
}

class CoursesLoadingState extends CoursesState {
  @override
  List<Object> get props => [];
}

class CoursesLoadedState extends CoursesState {
  final CoursesStatus status;
  final List<Course> courses;
  final bool hasReachedMax;
  final int page;
  final String searchKeyword;
  final CourseFilter courseFilter;

  CoursesLoadedState(
      {this.status = CoursesStatus.success,
      this.courses = const <Course>[],
      this.page = 1,
      this.hasReachedMax = false,
      this.searchKeyword = '',
      this.courseFilter});

  CoursesLoadedState copyWith({
    CoursesStatus status,
    List<Course> courses,
    int page = 1,
    bool hasReachedMax,
    String searchKeyword,
    CourseFilter courseFilter,
  }) {
    return CoursesLoadedState(
      status: status ?? this.status,
      courses: courses ?? this.courses,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      courseFilter: courseFilter ?? this.courseFilter,
    );
  }

  @override
  String toString() {
    return '''LoadedState  {status: $status hasReachedMax: $hasReachedMax, page: $page, courses: ${courses.length}, filter: $courseFilter }''';
  }

  @override
  List<Object> get props =>
      [status, courses, page, hasReachedMax, searchKeyword, courseFilter];
}

class CoursesLoadFailureState extends CoursesState {
  @override
  List<Object> get props => [];
}
