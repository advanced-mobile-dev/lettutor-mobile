import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/blocs/tutor_schedule/tutor_schedule_bloc.dart';
import 'package:lettutor_app/models/student_booking/student_booking.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'student_booking_event.dart';
part 'student_booking_state.dart';

const _dataPerPage = 5;

class StudentBookingBloc
    extends Bloc<StudentBookingEvent, StudentBookingState> {
  UserRepository _userRepository;
  StudentBookingBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(InitialState()) {
    on<StudentBookingFetchDataEvent>(_onFetchData);
    on<StudentBookingLoadMoreEvent>(_onLoadMore);
  }

  Future _onFetchData(StudentBookingFetchDataEvent event, emit) async {
    try {
      int dateTimeGte =
          DateTime.now().subtract(Duration(minutes: 30)).millisecondsSinceEpoch;
      final bookingList =
          await _userRepository.getBookingList(_dataPerPage, 1, dateTimeGte);
      emit(ListLoadedState(
          status: SBListStatus.success,
          page: 1,
          hasReachedMax: bookingList.data.length == bookingList.count,
          bookingList: bookingList.data));
    } catch (_) {
      emit(ListLoadFailureState());
    }
  }

  Future _onLoadMore(StudentBookingLoadMoreEvent event, emit) async {
    if (state is ListLoadedState) {
      final successState = (state as ListLoadedState);
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
        emit(LoadFailureState());
      }
    } else {
      return;
    }
  }
}