import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:music_player/logic/bloc/fav_block/favourite_bloc.dart';
import 'package:music_player/logic/cubit/cubit_player/player_cubit.dart';
import 'package:music_player/model/box-instance.dart';
import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/screens/Nowplaying/NowPlaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../openAudio/openaudio.dart';

class Favourites extends StatelessWidget {
  Favourites({Key? key}) : super(key: key);

  List<Songs>? databaseSongs = [];
  List<Audio> PlayLikedSong = [];
  // List<Songs>? Likedsongs = [];
  final box = boxes.getinstance();

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // var mediaquery1 = MediaQuery.of(context);
    
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
          begin: Alignment.center,
          end: Alignment.topRight,
          colors: [
            Color.fromARGB(255, 48, 133, 118),
            Color.fromARGB(255, 20, 68, 77)
          ]),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 70.h,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(125, 0, 25, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'F a v o u r i t e s',
                  style: TextStyle(
                      fontFamily: "poppinz",
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold),
                ),
             
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Container(
              width: width * 1.w,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 21, 25, 39),
                        Color.fromARGB(255, 85, 13, 69)
                      ])),
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                

                  child: BlocBuilder<FavouriteBloc, FavouriteState>(
                    builder: (context, state) {
                      var likedSongs = [];
                      if(state is FavDelete &&state.props[0] !=null){
                      likedSongs = state.props[0] as List<dynamic>;
                      }
                      return ListView.builder(
                          itemCount: likedSongs.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  for (var element in likedSongs) {
                                    PlayLikedSong.add(
                                      Audio.file(
                                        element.uri!,
                                        metas: Metas(
                                          title: element.title,
                                          id: element.id.toString(),
                                          artist: element.artist,
                                        ),
                                      ),
                                    );
                                  }
                                  OpenAssetAudio(
                                          allsong: PlayLikedSong, index: index)
                                      .openAsset(
                                          index: index, audios: PlayLikedSong);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PlayingSCreen(
                                                // index: index,
                                                audioSongs: PlayLikedSong,
                                              ))).then((value) {
                                    context
                                        .read<PlayerCubit>()
                                        .changeVisibility();
                                  });
                                },
                                child: ListTile(
                                  leading: SizedBox(
                                    height: 50.h,
                                    width: 50.w,
                                    child: QueryArtworkWidget(
                                      id: likedSongs[index].id!,
                                      type: ArtworkType.AUDIO,
                                      artworkBorder: BorderRadius.circular(15),
                                      artworkFit: BoxFit.cover,
                                      nullArtworkWidget: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          image: DecorationImage(
                                            image:
                                                AssetImage("assets/logo.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                    
                                      context.read<FavouriteBloc>().add(FavouriteDeleteEvent(index: index));
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                  title: Text(
                                    likedSongs[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: "poppinz",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    likedSongs[index].artist,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: "poppinz",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              ));
                    },
                  )),
            ),
          )
        ],
      )),
    );
  }
}
