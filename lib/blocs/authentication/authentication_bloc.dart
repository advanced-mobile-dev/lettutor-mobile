import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/repositories/authentication_repository.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  AuthenticationBloc(
      {@required AuthenticationRepository authenticationRepository,
      @required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(UnknownState()) {
    on<AuthenticationChangedEvent>(_onAuthenticationStatusChange);
    on<LogoutEvent>(_onLogoutEvent);
    _authenticationStatusSubscription =
        _authenticationRepository.status.listen((event) {
      add(AuthenticationChangedEvent(event));
    });
  }

  Future<void> _onAuthenticationStatusChange(AuthenticationChangedEvent event,
      Emitter<AuthenticationState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        _userRepository.removeUserInfo();
        return emit(UnAuthenticatedState());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        if (user != null) {
          return emit(AuthenticatedState(user: user));
        } else {
          _authenticationRepository.removeUserInfo();
          return emit(UnAuthenticatedState());
        }
        break;
      default:
        return emit(UnknownState());
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

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AuthenticationState> emit) async {
    _authenticationRepository.logout();
  }
}
