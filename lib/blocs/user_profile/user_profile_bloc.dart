import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserRepository _userRepository;
  UserProfileBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(InitialState()) {
    on<FetchUserInfodEvent>(_onFetchUserInfo);
    on<SavePressedEvent>(_onSavePressed);
  }
  Future _onFetchUserInfo(
      FetchUserInfodEvent event, Emitter<UserProfileState> emit) async {
    try {
      User user = await _tryGetUser();
      emit(user == null ? LoadFailureState() : LoadedState(user: user));
    } catch (_) {
      emit(LoadFailureState());
    }
  }

  Future _onSavePressed(
      SavePressedEvent event, Emitter<UserProfileState> emit) async {
    if (!(state is LoadedState)) return;
    final LoadedState currentState = state;
    emit(currentState.copyWith(userInfoStatus: UserInfoStatus.saving));
    try {
      final user = await _userRepository.putUserInfo(event.user, event.avatar);
      emit(user != null
          ? currentState.copyWith(
              user: user, userInfoStatus: UserInfoStatus.success)
          : currentState.copyWith(userInfoStatus: UserInfoStatus.failed));
    } catch (err, strace) {
      print(err);
      print(strace);
      emit(currentState.copyWith(userInfoStatus: UserInfoStatus.failed));
    }
  }

  Future<User> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
