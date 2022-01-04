part of 'tutor_booking_bloc.dart';

abstract class TutorBookingEvent extends Equatable {
  const TutorBookingEvent();

  @override
  List<Object> get props => [];
}

class FetchTutorSchedulesEvent extends TutorBookingEvent {}

class BookEvent extends TutorBookingEvent {
  final TutorSchedule tutorSchedule;

  BookEvent(this.tutorSchedule);
}
