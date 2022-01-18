part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object> get props => [];
}

class BookEvent extends ReservationEvent {
  final String note;
  BookEvent(this.note);
}
