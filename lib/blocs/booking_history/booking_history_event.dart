part of 'booking_history_bloc.dart';

abstract class BookingHistoryEvent extends Equatable {
  const BookingHistoryEvent();

  @override
  List<Object> get props => [];
}

class BookingHistoryFetchDataEvent extends BookingHistoryEvent {}

class BookingHistoryLoadMoreEvent extends BookingHistoryEvent {}

class BookingHistoryRefreshEvent extends BookingHistoryEvent {}
