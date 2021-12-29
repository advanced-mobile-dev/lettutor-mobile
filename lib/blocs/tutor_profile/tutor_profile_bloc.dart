import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tutor_profile_event.dart';
part 'tutor_profile_state.dart';

class TutorProfileBloc extends Bloc<TutorProfileEvent, TutorProfileState> {
  TutorProfileBloc() : super(TutorProfileInitial()) {
    on<TutorProfileEvent>((event, emit) {});
  }
}
