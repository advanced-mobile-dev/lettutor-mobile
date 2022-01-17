import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_app/data/network/exceptions/api_exception.dart';
import 'package:lettutor_app/repositories/authentication_repository.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final AuthenticationRepository _authenticationRepository;
  ForgetPasswordBloc(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(ForgetPasswordInitial()) {
    on<ForgetPasswordEvent>((event, emit) async {
      emit(ForgetPasswordInProgress());
      try {
        final bool result =
            await _authenticationRepository.forgetPassword(event.email);
        if (result)
          emit(ForgetPasswordSuccess());
        else
          emit(ForgetPasswordFailure('Failed'));
      } catch (error) {
        String message = 'Failed';
        if (error is ApiException) {
          message = error.message ?? message;
        }
        emit(ForgetPasswordFailure('$message'));
      }
    });
  }
}
