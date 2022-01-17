part of 'bottom_nav_bloc.dart';

enum AppTab { home, tutors, courses, settings }

class BottomNavState extends Equatable {
  final AppTab tab;
  const BottomNavState(this.tab);

  @override
  List<Object> get props => [tab];
}
