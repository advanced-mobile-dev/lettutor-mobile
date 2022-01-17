part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();
}

class TabChangeEvent extends BottomNavEvent {
  final int index;
  TabChangeEvent(this.index);

  @override
  List<Object> get props => [index];
}
