part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginByEmailEvent extends LoginEvent {
  final String email;
  final String password;
  LoginByEmailEvent({@required this.email, @required this.password});
}

class LoginByFacebookToken extends LoginEvent {
  final String token;
  LoginByFacebookToken(this.token);
}

class LoginByGoogleToken extends LoginEvent {
  final String token;
  LoginByGoogleToken(this.token);
}
