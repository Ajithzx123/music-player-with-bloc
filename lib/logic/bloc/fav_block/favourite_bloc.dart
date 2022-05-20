import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:music_player/model/box-instance.dart';
import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/screens/playlist/cusPlaylist.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final box = boxes.getinstance();

  FavouriteBloc()
      : super(FavDelete(list: boxes.getinstance().get("favorites"))) {
    on<FavouriteEvent>((event, emit) {
      if (event is FavouriteDeleteEvent) {
        final likedSongs = box.get("favorites");
        likedSongs!.removeAt(event.index);
        box.put("favorites", likedSongs);
        emit(FavDeleteSecond());

        emit(FavDelete(list: likedSongs));
      }
      // if (event is FAvouriteAddEvent) {
      //    final   databaseSongs = box.get('musics') as List<Songs>;

      //    final currentSong = databaseSongs.firstWhere((element) =>
      //       element.id.toString() == event.blocaudio.metas.id.toString());

      //   var likedSongs = box.get("favorites");
      //   likedSongs?.add(currentSong);
      //   box.put("favorites", likedSongs!);
      //   likedSongs = box.get("favorites");
        
      //   emit(FavAdd(list: likedSongs));
      // }
    });
  }
}
