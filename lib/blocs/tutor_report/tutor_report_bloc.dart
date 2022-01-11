import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'tutor_report_event.dart';
part 'tutor_report_state.dart';

class TutorReportBloc extends Bloc<TutorReportEvent, TutorReportState> {
  UserRepository _userRepository;
  Tutor _tutor;

  Tutor get tutor => _tutor;
  TutorReportBloc({Tutor tutor, UserRepository userRepository})
      : _userRepository = userRepository,
        _tutor = tutor,
        super(TutorReportInitialState()) {
    on<ReportEvent>(_onReport);
  }

  Future<void> _onReport(ReportEvent event, emit) async {
    try {
      emit(TutorReportLoadingState());
      final bool success =
          await _userRepository.reportTutor(_tutor.userId, event.content);
      if (success) {
        emit(ReportSuccessState());
      } else {
        emit(ReportFailedState());
      }
    } catch (error) {
      emit(ReportFailedState());
    }
  }
}
