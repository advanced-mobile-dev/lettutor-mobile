import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/blocs/tutor_schedule/tutor_schedule_bloc.dart';
import 'package:lettutor_app/models/student_schedule/student_schedule.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'student_schedule_event.dart';
part 'student_schedule_state.dart';

const _dataPerPage = 5;

class StudentScheduleBloc
    extends Bloc<StudentScheduleEvent, StudentScheduleState> {
  UserRepository _userRepository;
  StudentScheduleBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(InitialState()) {
    on<FetchDataEvent>(_onFetchData);
    on<LoadMoreEvent>(_onLoadMore);
  }

  Future _onFetchData(FetchDataEvent event, emit) async {
    try {
      int dateTimeGte =
          DateTime.now().subtract(Duration(minutes: 30)).millisecondsSinceEpoch;
      final scheduleList =
          await _userRepository.getScheduleList(_dataPerPage, 1, dateTimeGte);
      emit(ListLoadedState(
          status: SSListStatus.success,
          page: 1,
          hasReachedMax: scheduleList.data.length == scheduleList.count,
          scheduleList: scheduleList.data));
    } catch (_) {
      emit(ListLoadFailureState());
    }
  }

  Future _onLoadMore(LoadMoreEvent event, emit) async {
    if (state is ListLoadedState) {
      final successState = (state as ListLoadedState);
      if (successState.hasReachedMax ||
          successState.status != SSListStatus.success) return;
      emit(successState.copyWith(status: SSListStatus.loadingMore));
      try {
        //load more
        final int nextPage = successState.page + 1;
        int dateTimeGte = DateTime.now()
            .subtract(Duration(minutes: 30))
            .millisecondsSinceEpoch;
        final newScheduleList = await _userRepository.getScheduleList(
            _dataPerPage, nextPage, dateTimeGte);
        if (newScheduleList.data.isEmpty) {
          emit(successState.copyWith(
              status: SSListStatus.success,
              page: nextPage,
              hasReachedMax: true));
        } else {
          final bool hasReachedMax =
              successState.scheduleList.length + newScheduleList.data.length >=
                  newScheduleList.count;
          emit(
            successState.copyWith(
              status: SSListStatus.success,
              scheduleList: List.of(successState.scheduleList)
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
