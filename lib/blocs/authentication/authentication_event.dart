part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationChangedEvent extends AuthenticationEvent {
  final AuthenticationStatus status;

  AuthenticationChangedEvent(this.status);

  @override
  List<Object> get props => [status];
}

class LogoutEvent extends AuthenticationEvent {}
