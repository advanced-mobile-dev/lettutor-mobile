part of 'student_booking_bloc.dart';

enum SBListStatus { success, loadingMore, failure }

abstract class StudentBookingState extends Equatable {
  const StudentBookingState();

  @override
  List<Object> get props => [];
}

class InitialState extends StudentBookingState {}

class ListLoadingState extends StudentBookingState {}

class ListLoadedState extends StudentBookingState {
  final SBListStatus status;
  final List<StudentBooking> bookingList;
  final bool hasReachedMax;
  final int page;

  ListLoadedState(
      {this.status, this.bookingList, this.hasReachedMax, this.page});

  ListLoadedState copyWith({
    SBListStatus status,
    List<StudentBooking> bookingList,
    int page = 1,
    bool hasReachedMax,
  }) {
    return ListLoadedState(
      status: status ?? this.status,
      bookingList: bookingList ?? this.bookingList,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, bookingList, page, hasReachedMax];
}

class ListLoadFailureState extends StudentBookingState {}