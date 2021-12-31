part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginInprogressState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final String username;
  final String password;
  LoginSuccessState({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}

class LoginFailureState extends LoginState {
  final String errorMessage;
  LoginFailureState(this.errorMessage);
  @override
  List<Object> get props => [];
}
