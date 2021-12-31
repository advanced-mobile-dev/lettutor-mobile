part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  final String email;
  final String password;
  const SignUpEvent({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [];
}
