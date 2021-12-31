import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_app/data/network/api_exception.dart';
import 'package:lettutor_app/repositories/authentication_repo.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository _authenticationRepository;
  SignUpBloc(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpInProgress());
      try {
        await _authenticationRepository.signUp(
          event.email,
          event.password,
        );
        emit(SignUpSuccess());
      } catch (error) {
        String message = 'Sign up failed';
        if (error is ApiException) {
          message = error.message ?? message;
        }
        emit(SignUpFailure('$message'));
      }
    });
  }
}
