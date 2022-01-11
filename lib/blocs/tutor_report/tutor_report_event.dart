part of 'tutor_report_bloc.dart';

abstract class TutorReportEvent extends Equatable {
  const TutorReportEvent();

  @override
  List<Object> get props => [];
}

class ReportEvent extends TutorReportEvent {
  final String content;
  ReportEvent(this.content);
}
