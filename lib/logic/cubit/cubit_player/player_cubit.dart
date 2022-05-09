import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:music_player/main.dart';

part 'player_state.dart';


class PlayerCubit extends Cubit<PlayerCubitState> {
  PlayerCubit() : super(IconNowPlayingInitial());
  
  void changeVisibility() {
    preferences.setBool('isPlaying', true);

    emit(NowPlayButton());
  }

  IconData changeIcon(IconData iconData){
    emit(FavIcon(iconData: iconData));
    emit(ChangeSecondState());
    return iconData;
  }

   allSongs(Box<List<dynamic>> box){
    emit(DbList(allSongs: box));
    return box;
  }

 bool noti(bool value){
    emit(Notifi(switchChange: value));
    return value;
   
  }

 


  

}
