import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:music_player/model/box-instance.dart';

import '../../../model/hivemodel.dart';

part 'playlist_add_delete_state.dart';

class PlaylistAddDeleteCubit extends Cubit<PlaylistAddDeleteState> {
  PlaylistAddDeleteCubit() : super(PlaySongAdd());

  void changeIcon(
      {required IconData iconData,
      required String playListName,
      required Songs song}) async {
    var box = boxes.getinstance();
    List<Songs> list = box.get(playListName)!.cast<Songs>();
    if (iconData == Icons.add) {
      list.add(song);
      await box.put(
        playListName,
        list,
      );
      emit(PlaySongAdd());
    } else {
      list.removeWhere((elemet) => elemet.id.toString() == song.id.toString());
      await box.put(playListName, list);
      emit(PlaySongRemove());
    }
  }
  
}
