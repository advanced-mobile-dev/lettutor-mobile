import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_app/data/network/api-exception.dart';
import 'package:lettutor_app/repositories/authentication_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({@required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(InitialLoginState()) {
    on<LoginByEmailEvent>(_handleLoginByEmail);
    on<LoginByFacebookToken>(_handleFacebookLogin);
    on<LoginByGoogleToken>(_handleGoogleLogin);
  }

  Future<void> _handleLoginByEmail(
      LoginByEmailEvent event, Emitter<LoginState> emit) async {
    emit(LoginInprogressState());
    try {
      await _authenticationRepository.login(
        event.email,
        event.password,
      );
      emit(LoginSuccessState());
    } catch (error) {
      String message = 'Login failed';
      if (error is ApiException) {
        message = error.message ?? message;
      }
      emit(LoginFailureState('$message'));
    }
  }

  Future<void> _handleFacebookLogin(
      LoginByFacebookToken event, Emitter<LoginState> emit) async {
    emit(LoginInprogressState());
    try {
      await _authenticationRepository.facebookLogin(event.token);
      emit(LoginSuccessState());
    } catch (error) {
      String message = 'Login failed';
      if (error is ApiException) {
        message = error.message ?? message;
      }
      emit(LoginFailureState('$message'));
    }
  }

  Future<void> _handleGoogleLogin(
      LoginByGoogleToken event, Emitter<LoginState> emit) async {
    emit(LoginInprogressState());
    try {
      await _authenticationRepository.googleLogin(
        event.token,
      );
      emit(LoginSuccessState());
    } catch (error) {
      String message = 'Login failed';
      if (error is ApiException) {
        message = error.message ?? message;
      }
      emit(LoginFailureState('$message'));
    }
  }
}
