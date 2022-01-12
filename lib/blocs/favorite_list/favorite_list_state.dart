part of 'favorite_list_bloc.dart';

abstract class FavoriteListState extends Equatable {
  const FavoriteListState();

  @override
  List<Object> get props => [];
}

class FavoriteListInitial extends FavoriteListState {}

class FavoriteListLoading extends FavoriteListState {}

class FavoriteListLoaded extends FavoriteListState {
  final List<Tutor> favoriteList;

  FavoriteListLoaded(this.favoriteList);

  @override
  List<Object> get props => [favoriteList];
}

class FavoriteListLoadFailed extends FavoriteListState {}
