part of 'tutor_profile_bloc.dart';

enum TutorProfileStatus { initial, success, failed }

abstract class TutorProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class TutorProfileInitialState extends TutorProfileState {}

class TutorProfileLoadFailedState extends TutorProfileState {}

class TutorProfileLoadedState extends TutorProfileState {
  final Tutor tutor;
  TutorProfileLoadedState(this.tutor);

  copyWith({Tutor tutor, TutorProfileStatus tutorProfileStatus}) {
    return TutorProfileLoadedState(
      tutor ?? this.tutor,
    );
  }

  @override
  List<Object> get props => [tutor];
}
