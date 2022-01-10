part of 'tutor_profile_bloc.dart';

abstract class TutorProfileEvent extends Equatable {
  const TutorProfileEvent();

  @override
  List<Object> get props => [];
}

class FavoriteTutorEvent extends TutorProfileEvent {}

class ReportTutorEvent extends TutorProfileEvent {}
