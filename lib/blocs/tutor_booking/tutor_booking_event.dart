part of 'tutor_booking_bloc.dart';

abstract class TutorBookingEvent extends Equatable {
  const TutorBookingEvent();

  @override
  List<Object> get props => [];
}

class BookEvent extends TutorBookingEvent {
  final String note;
  BookEvent(this.note);
}
