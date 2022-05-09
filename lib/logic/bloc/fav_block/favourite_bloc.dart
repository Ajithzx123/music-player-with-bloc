import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/model/box-instance.dart';

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
        print("emittiong");
        emit(FavDeleteSecond());

        emit(FavDelete(list: likedSongs));
      }
    });
  }
}
