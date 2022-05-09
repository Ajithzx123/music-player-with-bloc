part of 'player_cubit.dart';

@immutable
abstract class PlayerCubitState extends Equatable {}

class IconNowPlayingInitial extends PlayerCubitState {
  @override
  List<Object?> get props => [];
}

class NowPlayButton extends PlayerCubitState {
  @override
  List<Object?> get props => [];
}

class FavIcon extends PlayerCubitState {
  final IconData iconData;
  FavIcon({required this.iconData});
  @override
  List<Object?> get props => [iconData];
}

class ChangeSecondState extends PlayerCubitState {
  @override
  List<Object?> get props => [];
}

class FavSong extends PlayerCubitState {
  final int dltsong;
  FavSong({required this.dltsong});
  @override
  List<Object?> get props => [dltsong];
}

class DbList extends PlayerCubitState {
  final Box<List<dynamic>> allSongs;
  DbList({required this.allSongs});
  @override
  List<Object?> get props => [allSongs];
}

class Notifi extends PlayerCubitState {
  final bool switchChange;
  Notifi({required this.switchChange});
  @override
  List<Object?> get props => [switchChange];
}
