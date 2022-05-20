part of 'fav_icon_cubit.dart';

abstract class FavIconState extends Equatable {
  const FavIconState();

  @override
  List<Object> get props => [];
}

class FavIconInitial extends FavIconState {}

class FavouriteAdded extends FavIconState{}

class FavouriteRemoved extends FavIconState{}