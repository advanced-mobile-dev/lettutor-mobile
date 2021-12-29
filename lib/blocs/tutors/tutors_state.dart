part of 'tutors_bloc.dart';

enum TutorStatus { initial, loading, success, failure }

abstract class TutorsState extends Equatable {
  List<Object> get props => [];
}

class LoadingState extends TutorsState {
  @override
  List<Object> get props => [];
}

class LoadSuccessState extends TutorsState {
  final List<Tutor> tutors;
  final bool hasReachedMax;
  final int page;
  final String searchKeyword;
  final TutorFilter tutorFilter;

  LoadSuccessState(
      {this.tutors = const <Tutor>[],
      this.page = 1,
      this.hasReachedMax = false,
      this.searchKeyword = '',
      this.tutorFilter});

  LoadSuccessState copyWith({
    List<Tutor> tutors,
    int page = 1,
    bool hasReachedMax,
    String searchKeyword,
    TutorFilter tutorFilter,
  }) {
    return LoadSuccessState(
      tutors: tutors ?? this.tutors,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      tutorFilter: tutorFilter ?? this.tutorFilter,
    );
  }

  @override
  String toString() {
    return '''LoadedState  { hasReachedMax: $hasReachedMax, page: $page, tutors: ${tutors.length}, filter: $tutorFilter }''';
  }

  @override
  List<Object> get props => [tutors, hasReachedMax];
}

class LoadFailureState extends TutorsState {
  @override
  List<Object> get props => [];
}
