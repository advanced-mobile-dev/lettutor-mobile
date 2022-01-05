import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/data/network/api_service.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/tutor_schedule/schedule_list.dart';
import 'package:lettutor_app/models/tutor_schedule/tutor_schedule.dart';

part 'tutor_booking_event.dart';
part 'tutor_booking_state.dart';

class TutorBookingBloc extends Bloc<TutorBookingEvent, TutorBookingState> {
  Tutor _tutor;
  TutorBookingBloc(Tutor tutor)
      : _tutor = tutor,
        super(TutorBookingInitial()) {
    on<FetchTutorSchedulesEvent>(_onFetchTutorSchedules);
    on<BookEvent>(_onBook);
  }

  Future<void> _onFetchTutorSchedules(event, emit) async {
    try {
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

  Future<void> _onBook(BookEvent event, emit) async {
    try {
      bool result = await ApiService().bookTutorClass(event.tutorSchedule);
      emit(result ? BookSuccessState() : BookFailureState());
    } catch (_) {
      emit(BookFailureState());
    }
  }
}
