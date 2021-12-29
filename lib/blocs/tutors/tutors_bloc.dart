import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lettutor_app/data/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/tutor/tutor-filter.dart';
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
    try {
      final tutorList = await Repository.getTutors(_tutorPerPage, 1,
          _tutorFilter.specialities.map((e) => e.code).toList());
      emit(LoadSuccessState(
          page: 1,
          hasReachedMax: tutorList.data.length >= tutorList.count,
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
      final sucessState = (state as LoadSuccessState);
      if (sucessState.hasReachedMax) return;

      try {
        //load more
        final int nextPage = sucessState.page + 1;
        final tutorList = await Repository.getTutors(
            _tutorPerPage,
            nextPage,
            // event.specialities.map((e) => e.code).toList()
            _tutorFilter.specialities.map((e) => e.code).toList());
        if (tutorList.data.isEmpty) {
          emit(sucessState.copyWith(page: nextPage, hasReachedMax: true));
        } else {
          emit(
            sucessState.copyWith(
              tutors: List.of(sucessState.tutors)..addAll(tutorList.data),
              hasReachedMax: false,
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
