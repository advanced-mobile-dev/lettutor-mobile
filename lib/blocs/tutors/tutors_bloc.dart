import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lettutor_app/data/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/tutor/tutor_filter.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';

part 'tutors_event.dart';
part 'tutors_state.dart';

const _tutorPerPage = 3;

class TutorsBloc extends Bloc<TutorsEvent, TutorsState> {
  TutorFilter _tutorFilter = TutorFilter(specialities: []);
  TutorFilter get tutorFilter => _tutorFilter;

  TutorsBloc() : super(LoadingState()) {
    on<TutorsFetchEvent>(_onTutorsFetch);
    on<TutorsLoadMoreEvent>(_onTutorsLoadMore);
    on<ApplyFilterEvent>(_onApplyFilter);
  }
  Future<void> _onTutorsFetch(
      TutorsFetchEvent event, Emitter<TutorsState> emit) async {
    print('on fetch');
    try {
      final tutorList = await Repository.getTutors(_tutorPerPage, 1,
          _tutorFilter.specialities.map((e) => e.code).toList());
      emit(LoadSuccessState(
          status: TutorsStatus.success,
          page: 1,
          hasReachedMax: tutorList.data.length == tutorList.count,
          tutorFilter: _tutorFilter,
          tutors: tutorList.data));
    } catch (_) {
      emit(LoadFailureState());
    }
  }

  Future<void> _onTutorsLoadMore(
      TutorsLoadMoreEvent event, Emitter<TutorsState> emit) async {
    // if (event.specialities!=null && event.specialities)

    if (state is LoadSuccessState) {
      final successState = (state as LoadSuccessState);
      if (successState.status != TutorsStatus.success ||
          successState.hasReachedMax) return;
      print('loading more');
      emit(successState.copyWith(status: TutorsStatus.loadingMore));
      try {
        //load more
        final int nextPage = successState.page + 1;
        final tutorList = await Repository.getTutors(
            _tutorPerPage,
            nextPage,
            // event.specialities.map((e) => e.code).toList()
            _tutorFilter.specialities.map((e) => e.code).toList());
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
        emit(LoadFailureState());
      }
    } else {
      return;
    }
  }

  Future<void> _onApplyFilter(
      ApplyFilterEvent event, Emitter<TutorsState> emit) async {
    emit(LoadingState());
    _tutorFilter = event.tutorFilter;
    try {
      final tutorList = await Repository.getTutors(_tutorPerPage, 1,
          _tutorFilter.specialities.map((e) => e.code).toList());
      emit(LoadSuccessState(
          page: 1,
          hasReachedMax: tutorList.data.length >= tutorList.count,
          tutors: tutorList.data,
          tutorFilter: event.tutorFilter));
    } catch (_) {
      emit(LoadFailureState());
    }
  }
  // Future<void> _handleApplyFilterEvent(
  //     ApplyFilterEvent event, Emitter<TutorsState> emit) async {
  //   if (event.specialities != null) {
  //     final newState = state.copyWith(
  //         status: TutorStatus.loading,
  //         tutors: const <Tutor>[],
  //         page: 1,
  //         hasReachedMax: false,
  //         specialities: event.specialities);
  //     emit(newState);
  //   }
  // }
}
