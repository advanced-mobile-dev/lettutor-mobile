part of 'tutor_report_bloc.dart';

abstract class TutorReportState extends Equatable {
  const TutorReportState();

  @override
  List<Object> get props => [];
}

class TutorReportInitialState extends TutorReportState {}

class TutorReportLoadingState extends TutorReportState {}

class ReportSuccessState extends TutorReportState {}

class ReportFailedState extends TutorReportState {}
