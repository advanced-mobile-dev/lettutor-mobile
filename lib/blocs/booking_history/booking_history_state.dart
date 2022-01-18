part of 'booking_history_bloc.dart';

enum BookingHistoryStatus { success, loadingMore, failure }

abstract class BookingHistoryState extends Equatable {
  const BookingHistoryState();

  List<Object> get props => [];
}

class BookingHistoryInitialState extends BookingHistoryState {}

class BookingHistoryLoadingState extends BookingHistoryState {}

class BookingHistoryLoadedState extends BookingHistoryState {
  final BookingHistoryStatus status;
  final List<Booking> bookingList;
  final bool hasReachedMax;
  final int page;

  BookingHistoryLoadedState(
      {this.status, this.bookingList, this.hasReachedMax, this.page});

  BookingHistoryLoadedState copyWith({
    BookingHistoryStatus status,
    List<Booking> bookingList,
    int page = 1,
    bool hasReachedMax,
  }) {
    return BookingHistoryLoadedState(
      status: status ?? this.status,
      bookingList: bookingList ?? this.bookingList,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, bookingList, page, hasReachedMax];
}

class BookingHistoryLoadFailureState extends BookingHistoryState {}
