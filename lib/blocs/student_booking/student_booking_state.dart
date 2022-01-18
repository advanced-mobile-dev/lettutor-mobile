part of 'student_booking_bloc.dart';

enum SBListStatus { success, loadingMore, failure }

abstract class StudentBookingState extends Equatable {
  const StudentBookingState();

  @override
  List<Object> get props => [];
}

class StudentBookingInitialState extends StudentBookingState {}

class StudentBookingLoadingState extends StudentBookingState {}

class StudentBookingLoadedState extends StudentBookingState {
  final SBListStatus status;
  final List<Booking> bookingList;
  final bool hasReachedMax;
  final int page;

  StudentBookingLoadedState(
      {this.status, this.bookingList, this.hasReachedMax, this.page});

  StudentBookingLoadedState copyWith({
    SBListStatus status,
    List<Booking> bookingList,
    int page = 1,
    bool hasReachedMax,
  }) {
    return StudentBookingLoadedState(
      status: status ?? this.status,
      bookingList: bookingList ?? this.bookingList,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, bookingList, page, hasReachedMax];
}

class StudentBookingLoadFailureState extends StudentBookingState {}
