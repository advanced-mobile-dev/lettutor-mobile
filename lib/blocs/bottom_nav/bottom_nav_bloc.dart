import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState(AppTab.home)) {
    on<TabChangeEvent>((TabChangeEvent event, emit) {
      emit(BottomNavState(AppTab.values[event.index]));
    });
  }
}
