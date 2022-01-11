part of 'favorite_tutor_bloc.dart';

abstract class FavoriteTutorState extends Equatable {
  const FavoriteTutorState();

  @override
  List<Object> get props => [];
}

class FavoriteTutorInitial extends FavoriteTutorState {}

class FavoriteSuccessState extends FavoriteTutorState {}

class FavoriteFailedState extends FavoriteTutorState {}
