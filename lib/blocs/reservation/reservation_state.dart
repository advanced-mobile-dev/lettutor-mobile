part of 'reservation_bloc.dart';

enum ReservationStatus { initial, loading, success, failed }

class ReservationState extends Equatable {
  final ReservationStatus reservationStatus;
  final Tutor tutor;
  final ScheduleDetail scheduleDetail;
  final UserWallet userWallet;
  final String errorMessage;
  const ReservationState(
      {this.reservationStatus = ReservationStatus.initial,
      this.tutor,
      this.scheduleDetail,
      this.userWallet,
      this.errorMessage = ''});
  copyWith(
      {ReservationStatus reservationStatus,
      UserWallet userWallet,
      String errorMessage}) {
    return ReservationState(
      tutor: this.tutor,
      scheduleDetail: this.scheduleDetail,
      reservationStatus: reservationStatus ?? this.reservationStatus,
      userWallet: userWallet ?? this.userWallet,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [reservationStatus, tutor, scheduleDetail];
}
