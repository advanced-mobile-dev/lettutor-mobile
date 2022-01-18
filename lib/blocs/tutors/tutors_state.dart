part of 'tutors_bloc.dart';

enum TutorsStatus { success, loadingMore, failure }

abstract class TutorsState extends Equatable {
  List<Object> get props => [];
}

class TutorsLoadingState extends TutorsState {
  @override
  List<Object> get props => [];
}

class TutorsLoadedState extends TutorsState {
  final TutorsStatus status;
  final List<Tutor> tutors;
  final bool hasReachedMax;
  final int page;
  final TutorFilter tutorFilter;

  TutorsLoadedState(
      {this.status = TutorsStatus.success,
      this.tutors = const <Tutor>[],
      this.page = 1,
      this.hasReachedMax = false,
      this.tutorFilter});

  TutorsLoadedState copyWith({
    TutorsStatus status,
    List<Tutor> tutors,
    int page = 1,
    bool hasReachedMax,
    String searchKeyword,
    TutorFilter tutorFilter,
  }) {
    return TutorsLoadedState(
      status: status ?? this.status,
      tutors: tutors ?? this.tutors,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      tutorFilter: tutorFilter ?? this.tutorFilter,
    );
  }

  @override
  String toString() {
    return 'TutorsLoadedState  {status: $status hasReachedMax: $hasReachedMax, page: $page, tutors: ${tutors.length}, filter: $tutorFilter }';
  }

  @override
  List<Object> get props => [status, tutors, page, hasReachedMax, tutorFilter];
}

class TutorsLoadFailureState extends TutorsState {
  @override
  List<Object> get props => [];
}

class FavoriteTutorsLoadedState extends TutorsState {
  @override
  List<Object> get props => [];
}
