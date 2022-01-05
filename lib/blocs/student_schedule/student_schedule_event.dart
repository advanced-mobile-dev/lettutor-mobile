part of 'student_schedule_bloc.dart';

abstract class StudentScheduleEvent extends Equatable {
  const StudentScheduleEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends StudentScheduleEvent {}

class LoadMoreEvent extends StudentScheduleEvent {}
