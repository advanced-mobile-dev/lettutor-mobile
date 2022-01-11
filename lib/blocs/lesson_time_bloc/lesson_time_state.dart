part of 'lesson_time_bloc.dart';

abstract class LessonTimeState extends Equatable {
  const LessonTimeState();
}

class LessonTimeInitialState extends LessonTimeState {
  @override
  List<Object> get props => [];
}

class LessonTimeLoadedState extends LessonTimeState {
  final Duration learnedTime;
  LessonTimeLoadedState(this.learnedTime);
  @override
  List<Object> get props => [learnedTime];
}

class LessonTimeLoadFailedState extends LessonTimeState {
  @override
  List<Object> get props => [];
}
