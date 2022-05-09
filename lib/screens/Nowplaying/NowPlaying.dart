import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/logic/cubit/cubit_player/player_cubit.dart';
import 'package:music_player/model/box-instance.dart';
import 'package:music_player/model/hivemodel.dart';

import 'package:music_player/widgets/playlistNowplay.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../widgets/snackbar.dart';

class PlayingSCreen extends StatefulWidget {
  List<Audio> audioSongs = [];
  PlayingSCreen({Key? key, required this.audioSongs, audiosongs})
      : super(key: key);

  @override
  State<PlayingSCreen> createState() => _PlayingSCreenState();
}

bool isnotify = true;

class _PlayingSCreenState extends State<PlayingSCreen> {
  Icon pause = const Icon(Icons.play_circle);
  Icon fav = const Icon(Icons.favorite_border);

  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");



  @override
  void initState() {
    super.initState();
    databaseSongs = box.get('musics') as List<Songs>;
    controller = TextEditingController();

  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  late TextEditingController controller;
  final box = boxes.getinstance();
  List<Songs> databaseSongs = [];
  List<dynamic>? likedSongs = [];
  List playlists = [];
  List<dynamic>? playlistSongs = [];
  String? playlistName = '';

  int rep = 1;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 9, 38, 61),
            Color.fromARGB(255, 117, 201, 159)
          ]),
      body: player.builderCurrent(builder: (context, Playing? playing) {
        print(playing!.audio.assetAudioPath);
        final myAudio = find(widget.audioSongs, playing.audio.assetAudioPath);

        final currentSong = databaseSongs.firstWhere((element) =>
            element.id.toString() == myAudio.metas.id.toString());

        likedSongs = box.get("favorites");
        if (playing.audio.assetAudioPath.isEmpty) {
          return const Center(
            child: Text('empty'),
          );
        } else {
          return SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 28.h,
                ),
                Text(
                  'N O W   P L A Y I N G',
                  style: TextStyle(
                      fontFamily: "poppinz",
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 70.h,
                ),
                Center(
                    child: Column(
                  children: [
                    Container(
                      width: 210.h,
                      height: 210.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: QueryArtworkWidget(
                        id: int.parse(myAudio.metas.id!),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: Container(
                          width: 240.w,
                          height: 240.w,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage(
                                  "assets/unknown.jpg",
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                  child: BlocBuilder<PlayerCubit, PlayerCubitState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          likedSongs!
                                  .where((element) =>
                                      element.id.toString() ==
                                      currentSong.id.toString())
                                  .isEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.favorite_outline,
                                    size: 27.w,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    likedSongs?.add(currentSong);
                                    box.put("favorites", likedSongs!);
                                    likedSongs = box.get("favorites");
                                    context
                                        .read<PlayerCubit>()
                                        .changeIcon(Icons.favorite_outline);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBars().likedAdd);
                                  },
                                )
                              : IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 27.w,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    likedSongs?.removeWhere((elemet) =>
                                        elemet.id.toString() ==
                                        currentSong.id.toString());
                                    box.put("favorites", likedSongs!);
                                    context
                                        .read<PlayerCubit>()
                                        .changeIcon(Icons.favorite);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                            SnackBars().likedRemove);
                                  },
                                ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20))),
                                    context: context,
                                    builder: (context) =>
                                        PlaylistNow(song: myAudio));
                              },
                              icon: Icon(
                                Icons.playlist_add,
                                color: Color.fromARGB(255, 207, 207, 207),
                                size: 32.w,
                              )),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 120, right: 120),
                  child: Container(
                      height: 27.h,
                      child: Marquee(
                          text: myAudio.metas.title!,
                          style: TextStyle(
                              fontFamily: "poppinz",
                              color: Colors.white,
                              fontSize: 23.sp,
                              fontWeight: FontWeight.bold),
                          pauseAfterRound: const Duration(seconds: 3),
                          velocity: 30,
                          blankSpace: 100)),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    myAudio.metas.artist!,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 23.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: BlocBuilder<PlayerCubit, PlayerCubitState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          player.builderLoopMode(
                            builder: (context, loopMode) {
                              return IconButton(
                                onPressed: () {
                                  if (loopMode == LoopMode.none) {
                                    player.setLoopMode(LoopMode.single);
                                  } else {
                                    player.setLoopMode(LoopMode.none);
                                  }
                                },
                                icon: (loopMode == LoopMode.none)
                                    ? const Icon(
                                        Icons.repeat,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.repeat_on_outlined,
                                        color: Colors.white,
                                      ),
                              );
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                player.toggleShuffle();

                                player.isShuffling.value
                                    ? context
                                        .read<PlayerCubit>()
                                        .changeIcon(Icons.shuffle_on_rounded)
                                    : context
                                        .read<PlayerCubit>()
                                        .changeIcon(Icons.shuffle);
                              },
                              icon: Icon(
                                player.isShuffling.value
                                    ? Icons.shuffle_on_rounded
                                    : Icons.shuffle,
                                color: Colors.white,
                              ))
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: seekBarWidget(context),
                ),
                SizedBox(
                  height: 20.h,
                ),
                
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              player.previous();
                            },
                            child: Icon(
                              Icons.arrow_circle_left,
                              size: 26.w,
                              color: Colors.white,
                            )),
                        SizedBox(
                          width: 30.w,
                        ),
                        PlayerBuilder.isPlaying(
                            player: player,
                            builder: (context, isPlaying) {
                              return GestureDetector(
                                onTap: () async {
                                  await player.playOrPause();
                                },
                                child: Icon(
                                  isPlaying
                                      ? Icons.pause_circle
                                      : Icons.play_circle,
                                  size: 65.w,
                                  color: Colors.white,
                                ),
                               
                              );
                            }),
                        SizedBox(
                          width: 30.w,
                        ),
                        GestureDetector(
                            onTap: () {
                              player.next();
                            },
                            child: Icon(
                              Icons.arrow_circle_right,
                              size: 26.w,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                )
              ],
            ),
          );
        }
      }),
    );
  }

  Widget seekBarWidget(BuildContext ctx) {
    return player.builderRealtimePlayingInfos(
      builder: (ctx, infos) {
        Duration cPos = infos.currentPosition;
        Duration total = infos.duration;
        return Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: ProgressBar(
            progress: cPos,
            total: total,
            progressBarColor: Colors.white,
            baseBarColor: Colors.grey,
            thumbColor: Colors.white,
            timeLabelLocation: TimeLabelLocation.sides,
            timeLabelTextStyle: const TextStyle(
              fontFamily: "poppinz",
              color: Colors.white,
            ),
            onSeek: (to) {
              player.seek(to);
            },
          ),
        );
      },
    );
  }
}
