import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/course/course.dart';
import 'package:lettutor_app/models/filter/course_filter.dart';
import 'package:lettutor_app/repositories/course_repository.dart';

part 'courses_event.dart';
part 'courses_state.dart';

const _coursePerPage = 6;

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CourseFilter _courseFilter =
      CourseFilter(levels: [], categories: [], keyword: '');
  CourseFilter get courseFilter => _courseFilter;

  CourseRepository _courseRepository;

  CoursesBloc({CourseRepository courseRepository})
      : _courseRepository = courseRepository,
        super(CoursesLoadingState()) {
    on<CoursesFetchEvent>(_onCoursesFetch);
    on<CoursesLoadMoreEvent>(_onCoursesLoadMore);
    on<CoursesRefreshEvent>(_onCoursesRefresh);
    on<ApplyCourseFilterEvent>(_onApplyFilter);
  }
  Future<void> _onCoursesFetch(
      CoursesFetchEvent event, Emitter<CoursesState> emit) async {
    try {
      final courseList =
          await _courseRepository.getCourses(_coursePerPage, 1, _courseFilter);
      emit(CoursesLoadedState(
          status: CoursesStatus.success,
          page: 1,
          hasReachedMax: courseList.data.length == courseList.count,
          courseFilter: _courseFilter,
          courses: courseList.data));
    } catch (err, trace) {
      print(err);
      print(trace);
      emit(CoursesLoadFailureState());
    }
  }

  Future<void> _onCoursesLoadMore(
      CoursesLoadMoreEvent event, Emitter<CoursesState> emit) async {
    // if (event.specialities!=null && event.specialities)
    if (state is CoursesLoadedState) {
      final successState = (state as CoursesLoadedState);
      if (successState.status != CoursesStatus.success ||
          successState.hasReachedMax) return;
      emit(successState.copyWith(status: CoursesStatus.loadingMore));

      try {
        //load more
        final int nextPage = successState.page + 1;
        final courseList = await _courseRepository.getCourses(
            _coursePerPage, nextPage, _courseFilter);
        if (courseList.data.isEmpty) {
          emit(successState.copyWith(
              status: CoursesStatus.success,
              page: nextPage,
              hasReachedMax: true));
        } else {
          final bool hasReachedMax =
              successState.courses.length + courseList.data.length >=
                  courseList.count;
          emit(
            successState.copyWith(
              status: CoursesStatus.success,
              courses: List.of(successState.courses)..addAll(courseList.data),
              hasReachedMax: hasReachedMax,
              courseFilter: _courseFilter,
              page: nextPage,
            ),
          );
        }
      } catch (err) {
        emit(CoursesLoadFailureState());
      }
    } else {
      return;
    }
  }

  Future<void> _onApplyFilter(
      ApplyCourseFilterEvent event, Emitter<CoursesState> emit) async {
    emit(CoursesLoadingState());
    _courseFilter = event.courseFilter;

    try {
      final courseList =
          await _courseRepository.getCourses(_coursePerPage, 1, _courseFilter);
      emit(CoursesLoadedState(
          page: 1,
          hasReachedMax: courseList.data.length >= courseList.count,
          courses: courseList.data,
          courseFilter: event.courseFilter));
    } catch (err, trace) {
      print(err);
      print(trace);
      emit(CoursesLoadFailureState());
    }
  }

  Future _onCoursesRefresh(
      CoursesRefreshEvent event, Emitter<CoursesState> emit) async {
    try {
      if (event.showLoading) emit(CoursesLoadingState());
      final courseList =
          await _courseRepository.getCourses(_coursePerPage, 1, _courseFilter);
      emit(CoursesLoadedState(
          status: CoursesStatus.success,
          page: 1,
          hasReachedMax: courseList.data.length == courseList.count,
          courseFilter: _courseFilter,
          courses: courseList.data));
    } catch (err, trace) {
      print(err);
      print(trace);
      emit(CoursesLoadFailureState());
    }
  }
}
