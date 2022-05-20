part of 'playlist_add_delete_cubit.dart';

abstract class PlaylistAddDeleteState {
  const PlaylistAddDeleteState();
}

class PlaySongAdd extends PlaylistAddDeleteState {}

class PlaySongRemove extends PlaylistAddDeleteState {}
