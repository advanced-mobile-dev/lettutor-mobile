import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'favorite_tutor_event.dart';
part 'favorite_tutor_state.dart';

class FavoriteTutorBloc extends Bloc<FavoriteTutorEvent, FavoriteTutorState> {
  UserRepository _userRepository;
  FavoriteTutorBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(FavoriteTutorInitial()) {
    on<FavoriteTutorEvent>(_onFavoriteTutor);
  }

  Future _onFavoriteTutor(FavoriteTutorEvent event, emit) async {
    try {
      final success = await _userRepository.favoriteTutor(event.tutor.userId);
      if (success) {
        emit(FavoriteSuccessState());
      } else
        emit(FavoriteFailedState());
    } catch (err, trace) {
      print(err);
      print(trace);
      emit(FavoriteFailedState());
    }
    emit(FavoriteTutorInitial());
  }
}
