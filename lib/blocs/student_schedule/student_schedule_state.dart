part of 'student_schedule_bloc.dart';

enum SSListStatus { success, loadingMore, failure }

abstract class StudentScheduleState extends Equatable {
  const StudentScheduleState();

  @override
  List<Object> get props => [];
}

class InitialState extends StudentScheduleState {}

class ListLoadingState extends StudentScheduleState {}

class ListLoadedState extends StudentScheduleState {
  final SSListStatus status;
  final List<StudentSchedule> scheduleList;
  final bool hasReachedMax;
  final int page;

  ListLoadedState(
      {this.status, this.scheduleList, this.hasReachedMax, this.page});

  ListLoadedState copyWith({
    SSListStatus status,
    List<StudentSchedule> scheduleList,
    int page = 1,
    bool hasReachedMax,
  }) {
    return ListLoadedState(
      status: status ?? this.status,
      scheduleList: scheduleList ?? this.scheduleList,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, scheduleList, page, hasReachedMax];
}

class ListLoadFailureState extends StudentScheduleState {}
