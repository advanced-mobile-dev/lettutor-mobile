import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/schedule/tutor_schedule_list.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/repositories/tutor_repository.dart';

part 'tutor_schedule_event.dart';
part 'tutor_schedule_state.dart';

class TutorScheduleBloc extends Bloc<TutorScheduleEvent, TutorScheduleState> {
  Tutor _tutor;
  TutorRepository _tutorRepository;
  TutorScheduleBloc({TutorRepository tutorRepository, Tutor tutor})
      : _tutorRepository = tutorRepository,
        _tutor = tutor,
        super(TutorScheduleInitial()) {
    on<TutorScheduleFetchEvent>(_onFetchTutorSchedules);
  }

  Future<void> _onFetchTutorSchedules(event, emit) async {
    try {
      emit(TutorScheduleLoading());
      TutorScheduleList schedules =
          await _tutorRepository.fetchTutorSchedules(_tutor.userId);
      emit(schedules == null
          ? TutorScheduleLoadFailureState()
          : TutorScheduleLoadedState(_tutor, schedules));
    } catch (error, trace) {
      print(error);
      print(trace);
      emit(TutorScheduleLoadFailureState());
    }
  }
}
