import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/booking/booking.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'student_booking_event.dart';
part 'student_booking_state.dart';

const _dataPerPage = 10;

class StudentBookingBloc
    extends Bloc<StudentBookingEvent, StudentBookingState> {
  UserRepository _userRepository;
  StudentBookingBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(StudentBookingInitialState()) {
    on<StudentBookingFetchDataEvent>(_onFetchData);
    on<StudentBookingLoadMoreEvent>(_onLoadMore);
    on<StudentBookingRefreshEvent>(_onRefreshEvent);
  }

  Future _onFetchData(StudentBookingFetchDataEvent event, emit) async {
    try {
      emit(StudentBookingLoadingState());
      int dateTimeGte =
          DateTime.now().subtract(Duration(minutes: 30)).millisecondsSinceEpoch;
      final bookingList =
          await _userRepository.getBookingList(_dataPerPage, 1, dateTimeGte);
      emit(StudentBookingLoadedState(
          status: SBListStatus.success,
          page: 1,
          hasReachedMax: bookingList.data.length == bookingList.count,
          bookingList: bookingList.data));
    } catch (_) {
      emit(StudentBookingLoadFailureState());
    }
  }

  Future _onLoadMore(StudentBookingLoadMoreEvent event, emit) async {
    if (state is StudentBookingLoadedState) {
      final successState = (state as StudentBookingLoadedState);
      if (successState.hasReachedMax ||
          successState.status != SBListStatus.success) return;
      emit(successState.copyWith(status: SBListStatus.loadingMore));
      try {
        //load more
        final int nextPage = successState.page + 1;
        int dateTimeGte = DateTime.now()
            .subtract(Duration(minutes: 30))
            .millisecondsSinceEpoch;
        final newScheduleList = await _userRepository.getBookingList(
            _dataPerPage, nextPage, dateTimeGte);
        if (newScheduleList.data.isEmpty) {
          emit(successState.copyWith(
              status: SBListStatus.success,
              page: nextPage,
              hasReachedMax: true));
        } else {
          final bool hasReachedMax =
              successState.bookingList.length + newScheduleList.data.length >=
                  newScheduleList.count;
          emit(
            successState.copyWith(
              status: SBListStatus.success,
              bookingList: List.of(successState.bookingList)
                ..addAll(newScheduleList.data),
              hasReachedMax: hasReachedMax,
              page: nextPage,
            ),
          );
        }
      } catch (err) {
        emit(StudentBookingLoadFailureState());
      }
    } else {
      return;
    }
  }

  Future _onRefreshEvent(StudentBookingRefreshEvent event,
      Emitter<StudentBookingState> emit) async {
    try {
      int dateTimeGte =
          DateTime.now().subtract(Duration(minutes: 30)).millisecondsSinceEpoch;
      final bookingList =
          await _userRepository.getBookingList(_dataPerPage, 1, dateTimeGte);
      emit(StudentBookingLoadedState(
          status: SBListStatus.success,
          page: 1,
          hasReachedMax: bookingList.data.length == bookingList.count,
          bookingList: bookingList.data));
    } catch (err, trace) {
      print(err);
      print(trace);
      emit(StudentBookingLoadFailureState());
    }
  }
}
