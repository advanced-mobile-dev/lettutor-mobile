import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'lesson_time_event.dart';
part 'lesson_time_state.dart';

class LessonTimeBloc extends Bloc<LessonTimeEvent, LessonTimeState> {
  UserRepository _userRepository;
  LessonTimeBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(LessonTimeInitialState()) {
    on<LessonTimeFetchEvent>(_onLessonTimeFetch);
  }

  Future _onLessonTimeFetch(
      LessonTimeFetchEvent event, Emitter<LessonTimeState> emit) async {
    try {
      final Duration learnedTime = await _userRepository.getLessonTime();
      if (learnedTime != null) {
        emit(LessonTimeLoadedState(learnedTime));
      } else {
        emit(LessonTimeLoadFailedState());
      }
    } catch (error) {
      print(error);
      emit(LessonTimeLoadFailedState());
    }
  }
}
