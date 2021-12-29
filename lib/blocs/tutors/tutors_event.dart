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

class ApplyFilterEvent extends TutorsEvent {
  final TutorFilter tutorFilter;
  ApplyFilterEvent({this.tutorFilter});
  @override
  List<Object> get props => [];
}
