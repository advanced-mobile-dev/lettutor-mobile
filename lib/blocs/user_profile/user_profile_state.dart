part of 'user_profile_bloc.dart';

enum UserInfoStatus { initial, saving, success, failed }

abstract class UserProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends UserProfileState {}

class LoadedState extends UserProfileState {
  final User user;
  final UserInfoStatus userInfoStatus;
  LoadedState({this.user, this.userInfoStatus = UserInfoStatus.initial});

  copyWith({User user, UserInfoStatus userInfoStatus}) {
    return LoadedState(
        user: user ?? this.user,
        userInfoStatus: userInfoStatus ?? this.userInfoStatus);
  }

  @override
  List<Object> get props => [user, userInfoStatus];
}

class LoadFailureState extends UserProfileState {}
