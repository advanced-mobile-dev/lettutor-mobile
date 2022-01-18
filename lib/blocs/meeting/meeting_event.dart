part of 'meeting_bloc.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props => [];
}

class StartMeetingEvent extends MeetingEvent {}

class CancelMeetingEvent extends MeetingEvent {}
