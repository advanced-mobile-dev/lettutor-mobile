part of 'lesson_time_bloc.dart';

abstract class LessonTimeEvent {
  const LessonTimeEvent();
}

class LessonTimeFetchEvent extends LessonTimeEvent {}
