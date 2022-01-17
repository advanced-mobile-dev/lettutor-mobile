import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/repositories/tutor_repository.dart';

part 'tutor_profile_event.dart';
part 'tutor_profile_state.dart';

class TutorProfileBloc extends Bloc<TutorProfileEvent, TutorProfileState> {
  TutorRepository _tutorRepository;
  String _tutorId;

  TutorProfileBloc({String tutorId, TutorRepository tutorRepository})
      : _tutorRepository = tutorRepository,
        _tutorId = tutorId,
        super(TutorProfileInitialState()) {
    on<TutorProfileFetchEvent>(_onTutorProfileFetch);
    on<TutorProfileRefreshEvent>(_onRefreshTutorProfile);
  }
  Future _onRefreshTutorProfile(TutorProfileRefreshEvent event, emit) async {
    try {
      final tutor = await _tutorRepository.getTutor(_tutorId);
      print(tutor.id);
      if (tutor != null)
        emit(TutorProfileLoadedState(tutor));
      else {
        emit(TutorProfileLoadFailedState());
      }
    } catch (err, trace) {
      print(err);
      print(trace);
      emit(TutorProfileLoadFailedState());
    }
  }

  Future _onTutorProfileFetch(
      TutorProfileFetchEvent event, Emitter<TutorProfileState> emit) async {
    try {
      final tutor = await _tutorRepository.getTutor(_tutorId);
      print(tutor.id);
      if (tutor != null)
        emit(TutorProfileLoadedState(tutor));
      else {
        emit(TutorProfileLoadFailedState());
      }
    } catch (err, trace) {
      print(err);
      print(trace);
      emit(TutorProfileLoadFailedState());
    }
  }
}
