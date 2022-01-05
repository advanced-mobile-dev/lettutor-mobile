part of 'tutor_booking_bloc.dart';

enum BookingStatus { initial, loading, success, failed }

class TutorBookingState extends Equatable {
  final BookingStatus bookingStatus;
  final Tutor tutor;
  final ScheduleDetail scheduleDetail;
  final UserWallet userWallet;
  final String errorMessage;
  const TutorBookingState(
      {this.bookingStatus = BookingStatus.initial,
      this.tutor,
      this.scheduleDetail,
      this.userWallet,
      this.errorMessage = ''});
  copyWith(
      {BookingStatus bookingStatus,
      UserWallet userWallet,
      String errorMessage}) {
    return TutorBookingState(
      tutor: this.tutor,
      scheduleDetail: this.scheduleDetail,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      userWallet: userWallet ?? this.userWallet,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [bookingStatus, tutor, scheduleDetail];
}
