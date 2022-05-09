import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:meta/meta.dart';

import '../../../model/hivemodel.dart';
import '../../../screens/playlist/cusPlaylist.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchResult(audios: [])) {
    on<EnterInputEvent>((event, emit) {
        List<Songs>   dbSongs = box.get("musics") as List<Songs>;
        List<Audio> allSongs = [];
    for (var element in dbSongs) {
      allSongs.add(
        Audio.file(
          element.uri.toString(),
          metas: Metas(
            title: element.title,
            id: element.id.toString(),
            artist: element.artist,
          ),
        ),
      );
    }

    List<Audio> searchResult = allSongs
        .where(
          (element) => element.metas.title!.toLowerCase().startsWith(
                event.searchInput.toLowerCase(),
              ),
        )
        .toList();

     emit(SearchResult(audios: searchResult));

    });
  }
}
