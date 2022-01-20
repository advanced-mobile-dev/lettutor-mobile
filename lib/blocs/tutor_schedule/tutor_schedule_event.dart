part of 'tutor_schedule_bloc.dart';

abstract class TutorScheduleEvent extends Equatable {
  const TutorScheduleEvent();

  @override
  List<Object> get props => [];
}

class TutorScheduleFetchEvent extends TutorScheduleEvent {}
