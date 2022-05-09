import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/logic/cubit/cubit_player/player_cubit.dart';
import 'package:music_player/model/box-instance.dart';
import 'package:music_player/openAudio/openaudio.dart';
import 'package:music_player/screens/Nowplaying/NowPlaying.dart';
import 'package:music_player/screens/playlist/cusPlaylist.dart';
import 'package:music_player/widgets/songadd.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../model/hivemodel.dart';

class InsideList extends StatefulWidget {
  String playlistName;

  InsideList({Key? key, required this.playlistName}) : super(key: key);

  @override
  State<InsideList> createState() => _InsideListState();
}

class _InsideListState extends State<InsideList> {
  List<Songs>? databasesongs = [];
  List<Songs>? playlistSongs = [];
  List<Audio> playlistsplay = [];

  final box = boxes.getinstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            height: 67.h,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(145, 0, 25, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150.w,
                  child: Text(
                    widget.playlistName,
                    maxLines: 1,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "poppinz",
                        color: Colors.white,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            return songadd(
                              playlistName: widget.playlistName,
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Container(
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
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, boxe, _) {
                    final playlistSongs = box.get(widget.playlistName)!;
                    return playlistSongs.isEmpty
                        ? SizedBox(
                            child: Center(
                              child: Text(
                                "No songs Here",
                                style: TextStyle(
                                    fontFamily: "poppinz",
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: playlistSongs.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                for (var element in playlistSongs) {
                                  playlistsplay.add(Audio.file(element.uri!,
                                      metas: Metas(
                                        title: element.title,
                                        id: element.id.toString(),
                                        artist: element.artist,
                                      )));
                                }

                                OpenAssetAudio(
                                        allsong: playlistsplay, index: index)
                                    .openAsset(
                                        index: index, audios: playlistsplay);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayingSCreen(
                                      audioSongs: playlistsplay,
                                      // index: index),
                                    ),
                                  ),
                                ).then((value) {
                                context
                                    .read<PlayerCubit>()
                                    .changeVisibility();
                              });
                              },
                              child: BlocBuilder<PlayerCubit, PlayerCubitState>(
                                builder: (context, state) {
                                  return ListTile(
                                    leading: SizedBox(
                                      height: 47.w,
                                      width: 47.w,
                                      child: QueryArtworkWidget(
                                        id: playlistSongs[index].id!,
                                        type: ArtworkType.AUDIO,
                                        artworkBorder:
                                            BorderRadius.circular(15),
                                        artworkFit: BoxFit.cover,
                                        nullArtworkWidget: Container(
                                          height: 47.w,
                                          width: 47.w,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/unknown.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      playlistSongs[index].title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: "poppinz",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.sp,
                                          color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      playlistSongs[index].artist!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: "poppinz",
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        
                                    
                                          playlistSongs.removeAt(index);
                                           box.put(widget.playlistName, playlistSongs);
                                          
                                       
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
