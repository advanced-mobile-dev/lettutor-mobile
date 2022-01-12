import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'favorite_list_event.dart';
part 'favorite_list_state.dart';

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  UserRepository _userRepository;
  FavoriteListBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(FavoriteListInitial()) {
    on<FavoriteListFetchEvent>(_onFetchEvent);
  }

  Future _onFetchEvent(FavoriteListFetchEvent event, emit) async {
    emit(FavoriteListLoading());
    try {
      final List<Tutor> favoriteList = await _userRepository.getFavoriteList();
      if (favoriteList != null) {
        emit(FavoriteListLoaded(favoriteList));
      } else {
        emit(FavoriteListLoadFailed());
      }
    } catch (error) {
      print(error);
      emit(FavoriteListLoadFailed());
    }
  }
}
