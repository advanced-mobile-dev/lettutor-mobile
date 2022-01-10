part of 'tutors_bloc.dart';

enum TutorsStatus { success, loadingMore, failure }

abstract class TutorsState extends Equatable {
  List<Object> get props => [];
}

class LoadingState extends TutorsState {
  @override
  List<Object> get props => [];
}

class LoadSuccessState extends TutorsState {
  final TutorsStatus status;
  final List<Tutor> tutors;
  final bool hasReachedMax;
  final int page;
  final TutorFilter tutorFilter;

  LoadSuccessState(
      {this.status = TutorsStatus.success,
      this.tutors = const <Tutor>[],
      this.page = 1,
      this.hasReachedMax = false,
      this.tutorFilter});

  LoadSuccessState copyWith({
    TutorsStatus status,
    List<Tutor> tutors,
    int page = 1,
    bool hasReachedMax,
    String searchKeyword,
    TutorFilter tutorFilter,
  }) {
    return LoadSuccessState(
      status: status ?? this.status,
      tutors: tutors ?? this.tutors,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      tutorFilter: tutorFilter ?? this.tutorFilter,
    );
  }

  @override
  String toString() {
    return '''LoadSuccessState  {status: $status hasReachedMax: $hasReachedMax, page: $page, tutors: ${tutors.length}, filter: $tutorFilter }''';
  }

  @override
  List<Object> get props => [status, tutors, page, hasReachedMax, tutorFilter];
}

class LoadFailureState extends TutorsState {
  @override
  List<Object> get props => [];
}
