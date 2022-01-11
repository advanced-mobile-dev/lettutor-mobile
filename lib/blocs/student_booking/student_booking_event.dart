part of 'student_booking_bloc.dart';

abstract class StudentBookingEvent extends Equatable {
  const StudentBookingEvent();

  @override
  List<Object> get props => [];
}

class StudentBookingFetchDataEvent extends StudentBookingEvent {}

class StudentBookingLoadMoreEvent extends StudentBookingEvent {}

class StudentBookingRefreshEvent extends StudentBookingEvent {}
