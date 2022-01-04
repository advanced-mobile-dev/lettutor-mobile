part of 'tutor_booking_bloc.dart';

abstract class TutorBookingState extends Equatable {
  const TutorBookingState();

  @override
  List<Object> get props => [];
}

class TutorBookingInitial extends TutorBookingState {}

class SchedulesLoadedState extends TutorBookingState {
  final ScheduleList tutorSchedules;

  SchedulesLoadedState(this.tutorSchedules);
}

class LoadFailureState extends TutorBookingState {}

class BookSuccessState extends TutorBookingState {}

class BookFailureState extends TutorBookingState {}
