part of 'tutor_schedule_bloc.dart';

abstract class TutorScheduleState extends Equatable {
  const TutorScheduleState();

  @override
  List<Object> get props => [];
}

class TutorBookingInitial extends TutorScheduleState {}

class SchedulesLoadedState extends TutorScheduleState {
  final Tutor tutor;
  final ScheduleList tutorSchedules;

  SchedulesLoadedState(this.tutor, this.tutorSchedules);
}

class LoadFailureState extends TutorScheduleState {}

class BookSuccessState extends TutorScheduleState {}

class BookFailureState extends TutorScheduleState {}
