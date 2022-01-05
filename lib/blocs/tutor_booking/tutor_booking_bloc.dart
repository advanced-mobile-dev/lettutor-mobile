import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/data/network/api_exception.dart';
import 'package:lettutor_app/models/schedule/booking_info.dart';
import 'package:lettutor_app/models/schedule/schedule_detail.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/models/user/user_wallet.dart';
import 'package:lettutor_app/repositories/payment_repo.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'tutor_booking_event.dart';
part 'tutor_booking_state.dart';

class TutorBookingBloc extends Bloc<TutorBookingEvent, TutorBookingState> {
  UserRepository _userRepository;
  PaymentRepository _paymentRepository;
  TutorBookingBloc(
      {Tutor tutor,
      ScheduleDetail scheduleDetail,
      UserRepository userRepository,
      PaymentRepository paymentRepository})
      : _userRepository = userRepository,
        _paymentRepository = paymentRepository,
        super(TutorBookingState(
            tutor: tutor,
            scheduleDetail: scheduleDetail,
            userWallet: userRepository.user.userWallet)) {
    on<BookEvent>(_onBook);
  }

  Future<void> _onBook(BookEvent event, emit) async {
    try {
      emit(state.copyWith(bookingStatus: BookingStatus.loading));
      List<BookingInfo> results = await _paymentRepository.bookClass(
          state.scheduleDetail.id, event.note);
      //update user wallet
      if (results != null && results.length > 0) {
        try {
          final User user = await _userRepository.getUser();
          emit(state.copyWith(
              bookingStatus: BookingStatus.success,
              userWallet: user.userWallet));
          return;
        } catch (_) {
          emit(state.copyWith(bookingStatus: BookingStatus.success));
        }
      } else {
        emit(state.copyWith(
            bookingStatus: BookingStatus.failed,
            errorMessage: 'Something went wrong, please try again'));
      }
    } catch (error) {
      String message = '';
      if (error is ApiException) {
        message = error.message ?? message;
      }
      emit(state.copyWith(
          bookingStatus: BookingStatus.failed, errorMessage: '$message'));
    }
  }
}
