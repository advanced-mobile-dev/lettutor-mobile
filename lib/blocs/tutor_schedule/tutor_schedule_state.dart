part of 'tutor_schedule_bloc.dart';

abstract class TutorScheduleState extends Equatable {
  const TutorScheduleState();

  @override
  List<Object> get props => [];
}

class TutorScheduleInitial extends TutorScheduleState {}

class TutorScheduleLoading extends TutorScheduleState {}

class TutorScheduleLoadedState extends TutorScheduleState {
  final Tutor tutor;
  final TutorScheduleList tutorSchedules;

  TutorScheduleLoadedState(this.tutor, this.tutorSchedules);
}

class TutorScheduleLoadFailureState extends TutorScheduleState {}

// class BookSuccessState extends TutorScheduleState {}

// class BookFailureState extends TutorScheduleState {}
