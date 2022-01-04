import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';

part 'tutor_booking_event.dart';
part 'tutor_booking_state.dart';

class TutorBookingBloc extends Bloc<TutorBookingEvent, TutorBookingState> {
  Tutor _tutor;
  TutorBookingBloc(Tutor tutor)
      : _tutor = tutor,
        super(TutorBookingInitial()) {
    on<TutorBookingEvent>((event, emit) {});
  }
}
