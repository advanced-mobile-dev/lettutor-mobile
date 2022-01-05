import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/data/network/api_service.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/tutor_schedule/schedule_list.dart';
import 'package:lettutor_app/models/tutor_schedule/tutor_schedule.dart';

part 'tutor_schedule_event.dart';
part 'tutor_schedule_state.dart';

class TutorScheduleBloc extends Bloc<TutorScheduleEvent, TutorScheduleState> {
  Tutor _tutor;
  TutorScheduleBloc(Tutor tutor)
      : _tutor = tutor,
        super(TutorBookingInitial()) {
    on<FetchTutorSchedulesEvent>(_onFetchTutorSchedules);
  }

  Future<void> _onFetchTutorSchedules(event, emit) async {
    try {
      emit(TutorBookingInitial());
      ScheduleList schedules =
          await ApiService().fetchTutorSchedules(_tutor.userId);
      emit(schedules == null
          ? LoadFailureState()
          : SchedulesLoadedState(_tutor, schedules));
    } catch (error) {
      print(error);
      emit(LoadFailureState());
    }
  }
}
