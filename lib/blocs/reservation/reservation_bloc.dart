import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/data/network/exceptions/api_exception.dart';
import 'package:lettutor_app/models/booking/booking_info.dart';
import 'package:lettutor_app/models/schedule/schedule_detail.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/models/user/user_wallet.dart';
import 'package:lettutor_app/repositories/payment_repository.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  UserRepository _userRepository;
  PaymentRepository _paymentRepository;
  ReservationBloc(
      {Tutor tutor,
      ScheduleDetail scheduleDetail,
      UserRepository userRepository,
      PaymentRepository paymentRepository})
      : _userRepository = userRepository,
        _paymentRepository = paymentRepository,
        super(ReservationState(
            tutor: tutor,
            scheduleDetail: scheduleDetail,
            userWallet: userRepository.user.userWallet)) {
    on<BookEvent>(_onBook);
  }

  Future<void> _onBook(BookEvent event, emit) async {
    try {
      emit(state.copyWith(reservationStatus: ReservationStatus.loading));
      List<BookingInfo> results = await _paymentRepository.bookClass(
          state.scheduleDetail.id, event.note);
      //update user wallet
      if (results != null && results.length > 0) {
        try {
          final User user = await _userRepository.getUser();
          emit(state.copyWith(
              reservationStatus: ReservationStatus.success,
              userWallet: user.userWallet));
          return;
        } catch (_) {
          emit(state.copyWith(reservationStatus: ReservationStatus.success));
        }
      } else {
        emit(state.copyWith(
            reservationStatus: ReservationStatus.failed,
            errorMessage: 'Something went wrong, please try again'));
      }
    } catch (error) {
      String message = '';
      if (error is ApiException) {
        message = error.message ?? message;
      }
      emit(state.copyWith(
          reservationStatus: ReservationStatus.failed,
          errorMessage: '$message'));
    }
  }
}
