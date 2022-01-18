import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/filter/tutor_filter.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/repositories/tutor_repository.dart';

part 'tutors_event.dart';
part 'tutors_state.dart';

const _tutorPerPage = 5;

class TutorsBloc extends Bloc<TutorsEvent, TutorsState> {
  TutorFilter _tutorFilter = TutorFilter(specialities: [], keyword: '');
  TutorFilter get tutorFilter => _tutorFilter;

  TutorRepository _tutorRepository;

  TutorsBloc({TutorRepository tutorRepository})
      : _tutorRepository = tutorRepository,
        super(TutorsLoadingState()) {
    on<TutorsFetchEvent>(_onTutorsFetch);
    on<TutorsLoadMoreEvent>(_onTutorsLoadMore);
    on<ApplyTutorFilterEvent>(_onApplyFilter);
    on<TutorsRefreshEvent>(_onTutorsRefresh);
  }
  Future<void> _onTutorsFetch(
      TutorsFetchEvent event, Emitter<TutorsState> emit) async {
    try {
      final tutorList =
          await _tutorRepository.getTutors(_tutorPerPage, 1, _tutorFilter);
      emit(TutorsLoadedState(
          status: TutorsStatus.success,
          page: 1,
          hasReachedMax: tutorList.data.length == tutorList.count,
          tutorFilter: _tutorFilter,
          tutors: tutorList.data));
    } catch (_) {
      emit(TutorsLoadFailureState());
    }
  }

  Future<void> _onTutorsLoadMore(
      TutorsLoadMoreEvent event, Emitter<TutorsState> emit) async {
    // if (event.specialities!=null && event.specialities)

    if (state is TutorsLoadedState) {
      final successState = (state as TutorsLoadedState);
      if (successState.status != TutorsStatus.success ||
          successState.hasReachedMax) return;
      print('loading more');
      emit(successState.copyWith(status: TutorsStatus.loadingMore));
      try {
        //load more
        final int nextPage = successState.page + 1;
        final tutorList = await _tutorRepository.getTutors(
            _tutorPerPage,
            nextPage,
            // event.specialities.map((e) => e.code).toList()
            _tutorFilter);
        if (tutorList.data.isEmpty) {
          emit(successState.copyWith(
              status: TutorsStatus.success,
              page: nextPage,
              hasReachedMax: true));
        } else {
          final bool hasReachedMax =
              successState.tutors.length + tutorList.data.length >=
                  tutorList.count;
          emit(
            successState.copyWith(
              status: TutorsStatus.success,
              tutors: List.of(successState.tutors)..addAll(tutorList.data),
              hasReachedMax: hasReachedMax,
              tutorFilter: _tutorFilter,
              page: nextPage,
            ),
          );
        }
      } catch (err) {
        emit(TutorsLoadFailureState());
      }
    } else {
      return;
    }
  }

  Future<void> _onApplyFilter(
      ApplyTutorFilterEvent event, Emitter<TutorsState> emit) async {
    emit(TutorsLoadingState());
    _tutorFilter = event.tutorFilter;
    try {
      final tutorList =
          await _tutorRepository.getTutors(_tutorPerPage, 1, _tutorFilter);
      emit(TutorsLoadedState(
          page: 1,
          hasReachedMax: tutorList.data.length >= tutorList.count,
          tutors: tutorList.data,
          tutorFilter: event.tutorFilter));
    } catch (_) {
      emit(TutorsLoadFailureState());
    }
  }

  Future _onTutorsRefresh(
      TutorsRefreshEvent event, Emitter<TutorsState> emit) async {
    try {
      if (event.showLoading) emit(TutorsLoadingState());
      final tutorList =
          await _tutorRepository.getTutors(_tutorPerPage, 1, _tutorFilter);
      emit(TutorsLoadedState(
          status: TutorsStatus.success,
          page: 1,
          hasReachedMax: tutorList.data.length == tutorList.count,
          tutorFilter: _tutorFilter,
          tutors: tutorList.data));
    } catch (err, trace) {
      print(err);
      print(trace);
      emit(TutorsLoadFailureState());
    }
  }
}
