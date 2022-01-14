part of 'tutors_bloc.dart';

abstract class TutorsEvent extends Equatable {}

class TutorsFetchEvent extends TutorsEvent {
  TutorsFetchEvent();

  @override
  List<Object> get props => [];
}

class TutorsLoadMoreEvent extends TutorsEvent {
  TutorsLoadMoreEvent();

  @override
  List<Object> get props => [];
}

class ApplyTutorFilterEvent extends TutorsEvent {
  final TutorFilter tutorFilter;
  ApplyTutorFilterEvent({this.tutorFilter});
  @override
  List<Object> get props => [];
}

class TutorsRefreshEvent extends TutorsEvent {
  final bool showLoading;
  TutorsRefreshEvent({this.showLoading = false});
  @override
  List<Object> get props => [];
}
