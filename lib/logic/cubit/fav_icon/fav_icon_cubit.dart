import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/model/box-instance.dart';
import 'package:music_player/screens/playlist/cusPlaylist.dart';

import '../../../model/hivemodel.dart';

part 'fav_icon_state.dart';

class FavIconCubit extends Cubit<FavIconState> {
  List<dynamic>? boxListFavourite = boxes.getinstance().get('favourites');
  final AssetsAudioPlayer player = AssetsAudioPlayer();
  final databaseSongs = box.get("musics") as List<Songs>;
   List<Audio> audioSongs = [];
  late Songs currentSong;
  late String current;

  FavIconCubit() : super(FavIconInitial()) {
    databaseSongs.forEach((element) {
      audioSongs.add(Audio.file(element.uri.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist)));
    });
    var playing = player.current.listen((playing) {
       current = playing!.audio.audio.path;
    });
    // print(playing.);
    // if(playing.hasValue){
    //   current = playing.value!.audio.assetAudioPath;
    // }

    Audio audio = find(audioSongs, current);

    currentSong = databaseSongs.firstWhere(
        (element) => element.id.toString() == audio.metas.id.toString());

    if (boxListFavourite!
        .where((element) => element.id.toString() == currentSong.id.toString())
        .isEmpty) {
      emit(FavouriteRemoved());
    } else {
      emit(FavouriteAdded());
    }
  }

  void addFavourite() {
    boxListFavourite?.add(currentSong);
    box.put("favorites", boxListFavourite!);
    boxListFavourite = box.get("favorites");
    emit(FavouriteAdded());
  }

  void removeFavourite() {
    boxListFavourite?.removeWhere(
        (elemet) => elemet.id.toString() == currentSong.id.toString());
    box.put("favorites", boxListFavourite!);
    emit(FavouriteRemoved());
  }
}

Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}
