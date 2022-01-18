import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/booking/booking.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'booking_history_event.dart';
part 'booking_history_state.dart';

const _dataPerPage = 5;

class BookingHistoryBloc
    extends Bloc<BookingHistoryEvent, BookingHistoryState> {
  UserRepository _userRepository;
  BookingHistoryBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(BookingHistoryInitialState()) {
    on<BookingHistoryFetchDataEvent>(_onFetchData);
    on<BookingHistoryLoadMoreEvent>(_onLoadMore);
    on<BookingHistoryRefreshEvent>(_onRefreshEvent);
  }

  Future _onFetchData(BookingHistoryFetchDataEvent event, emit) async {
    try {
      emit(BookingHistoryLoadingState());
      int dateTimeLte =
          DateTime.now().subtract(Duration(minutes: 30)).millisecondsSinceEpoch;
      final bookingList =
          await _userRepository.getBookingHistory(_dataPerPage, 1, dateTimeLte);
      emit(BookingHistoryLoadedState(
          status: BookingHistoryStatus.success,
          page: 1,
          hasReachedMax: bookingList.data.length == bookingList.count,
          bookingList: bookingList.data));
    } catch (_) {
      emit(BookingHistoryLoadFailureState());
    }
  }

  Future _onRefreshEvent(BookingHistoryRefreshEvent event, emit) async {
    try {
      int dateTimeLte =
          DateTime.now().subtract(Duration(minutes: 30)).millisecondsSinceEpoch;
      final bookingList =
          await _userRepository.getBookingHistory(_dataPerPage, 1, dateTimeLte);
      emit(BookingHistoryLoadedState(
          status: BookingHistoryStatus.success,
          page: 1,
          hasReachedMax: bookingList.data.length == bookingList.count,
          bookingList: bookingList.data));
    } catch (error) {
      emit(BookingHistoryLoadFailureState());
    }
  }

  Future _onLoadMore(BookingHistoryLoadMoreEvent event, emit) async {
    if (state is BookingHistoryLoadedState) {
      final successState = (state as BookingHistoryLoadedState);
      if (successState.hasReachedMax ||
          successState.status != BookingHistoryStatus.success) return;
      emit(successState.copyWith(status: BookingHistoryStatus.loadingMore));
      try {
        //load more
        final int nextPage = successState.page + 1;
        int dateTimeLte = DateTime.now()
            .subtract(Duration(minutes: 30))
            .millisecondsSinceEpoch;
        final newScheduleList = await _userRepository.getBookingHistory(
            _dataPerPage, nextPage, dateTimeLte);
        if (newScheduleList.data.isEmpty) {
          emit(successState.copyWith(
              status: BookingHistoryStatus.success,
              page: nextPage,
              hasReachedMax: true));
        } else {
          final bool hasReachedMax =
              successState.bookingList.length + newScheduleList.data.length >=
                  newScheduleList.count;
          emit(
            successState.copyWith(
              status: BookingHistoryStatus.success,
              bookingList: List.of(successState.bookingList)
                ..addAll(newScheduleList.data),
              hasReachedMax: hasReachedMax,
              page: nextPage,
            ),
          );
        }
      } catch (err) {
        emit(BookingHistoryLoadFailureState());
      }
    } else {
      return;
    }
  }
}
