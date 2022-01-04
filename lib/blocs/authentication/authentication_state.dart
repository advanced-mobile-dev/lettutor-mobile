part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class UnknownState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthenticationState {
  final User user;

  AuthenticatedState({this.user});

  @override
  List<Object> get props => [user];
}

class UnAuthenticatedState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
