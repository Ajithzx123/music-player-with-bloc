import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/logic/cubit/cubit_player/player_cubit.dart';
import 'package:music_player/model/box-instance.dart';
import 'package:music_player/openAudio/openaudio.dart';
import 'package:music_player/screens/Nowplaying/NowPlaying.dart';
import 'package:music_player/screens/favourites/favouritesScreen.dart';
import 'package:music_player/screens/playlist/playlist.dart';
import 'package:music_player/screens/settings/settings.dart';
import 'package:music_player/widgets/playlistNowplay.dart';
import 'package:music_player/widgets/search.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../model/hivemodel.dart';
import '../../widgets/snackbar.dart';

class MainScreen extends StatefulWidget {
  List<Audio> audiosongs = [];
  MainScreen({Key? key, required this.audiosongs}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List? databasesongs = [];

  List playlists = [];
  List<dynamic>? favorites = [];
  String? playlistName = '';

  List<dynamic>? likedsongs = [];

  bool nowplays = true;

  final box = boxes.getinstance();
  final AssetsAudioPlayer assetaudioplayer = AssetsAudioPlayer.withId("0");
  final audioQuery = OnAudioQuery();

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  int selectedIndex = 0;
  Icon customIcon = const Icon(Icons.search);

  bool isTrue = true;
  bool isSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databasesongs = box.get('musics');
    likedsongs = box.get("favorites");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var mediaquery1 = MediaQuery.of(context);
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromARGB(255, 104, 103, 44),
          Color.fromARGB(255, 83, 25, 66)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15.h),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const Settings())));
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 26.w,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>  Favourites())));
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 26.w,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            FittedBox(
              child: Text(
                'All Songs',
                style: TextStyle(
                    fontFamily: "poppinz",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              child: Stack(children: [
                Container(
                  height: height * 1.h,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 21, 32, 41),
                          Color.fromARGB(255, 44, 46, 27),
                          Color.fromARGB(255, 54, 26, 24)
                        ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                        itemCount: widget.audiosongs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: ListTile(
                              title: Text(
                                widget.audiosongs[index].metas.title!
                                    .toString(),
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    fontFamily: "poppinz",
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                widget.audiosongs[index].metas.artist!
                                    .toString(),
                                maxLines: 1,
                                style: TextStyle(
                                    // fontFamily: "poppinz",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              leading: SizedBox(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: QueryArtworkWidget(
                                      nullArtworkWidget: Image.asset(
                                        "assets/unknown.jpg",
                                        width: 45.w,
                                        height: 45.w,
                                        fit: BoxFit.cover,
                                      ),
                                      id: int.parse(widget
                                          .audiosongs[index].metas.id
                                          .toString()),
                                      type: ArtworkType.AUDIO),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      likedsongs = box.get("favorites");
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 71, 26, 23),
                                                    Color.fromARGB(
                                                        255, 13, 41, 64)
                                                  ]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      "Add to Playlist",
                                                      style: TextStyle(
                                                          fontFamily: "poppinz",
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.sp),
                                                    ),
                                                    // trailing: const Icon(Icons.add),
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              20))),
                                                          context: context,
                                                          builder: (context) =>
                                                              PlaylistNow(
                                                                  song: widget
                                                                          .audiosongs[
                                                                      index]));
                                                    },
                                                  ),
                                                  likedsongs!
                                                          .where((element) =>
                                                              element.id
                                                                  .toString() ==
                                                              databasesongs![
                                                                      index]
                                                                  .id
                                                                  .toString())
                                                          .isEmpty
                                                      ? ListTile(
                                                          title: const Text(
                                                              "Add to Favorites",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "poppinz",
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18)),
                                                          onTap: () async {
                                                            final songs = box
                                                                    .get(
                                                                        "musics")
                                                                as List<Songs>;
                                                            final temp = songs.firstWhere((element) =>
                                                                element.id
                                                                    .toString() ==
                                                                widget
                                                                    .audiosongs[
                                                                        index]
                                                                    .metas
                                                                    .id
                                                                    .toString());
                                                            favorites =
                                                                likedsongs;
                                                            favorites
                                                                ?.add(temp);
                                                            box.put("favorites",
                                                                favorites!);

                                                            Navigator.of(
                                                                    context)
                                                                .pop();

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBars()
                                                                        .likedAdd);
                                                          },
                                                        )
                                                      : ListTile(
                                                          title: Text(
                                                            "Remove from Favorites",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "poppinz",
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    18.sp),
                                                          ),
                                                          onTap: () async {
                                                            likedsongs?.removeWhere((elemet) =>
                                                                elemet.id
                                                                    .toString() ==
                                                                databasesongs![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                            await box.put(
                                                                "favorites",
                                                                likedsongs!);

                                                            Navigator.of(
                                                                    context)
                                                                .pop();

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBars()
                                                                        .likedRemove);
                                                          },
                                                        ),
                                                ]),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () async {
                              // preferences.setBool('isPlaying', true);
                              await OpenAssetAudio(allsong: [], index: index)
                                  .openAsset(
                                      index: index, audios: widget.audiosongs);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayingSCreen(
                                    audioSongs: widget.audiosongs,
                                  ),
                                ),
                              ).then((value) {
                                context
                                    .read<PlayerCubit>()
                                    .changeVisibility();
                              });
                            },
                          );
                        }),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      // width: 300,
                      height: 55.h,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            const Color.fromARGB(255, 32, 50, 65)
                                .withOpacity(1),
                            const Color.fromARGB(255, 107, 60, 93)
                                .withOpacity(1),
                            const Color.fromARGB(255, 23, 104, 100)
                                .withOpacity(1)
                          ]),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Playlists(),
                                      ));
                                },
                                icon: Icon(
                                  Icons.playlist_play_sharp,
                                  color: Colors.white,
                                  size: 30.w,
                                )),
                            SizedBox(
                              width: 35.w,
                            ),
                            BlocBuilder<PlayerCubit, PlayerCubitState>(
                              builder: (context, state) {
                                return Visibility(
                                  visible: preferences.getBool('isPlaying')!,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PlayingSCreen(
                                                audioSongs: widget.audiosongs,
                                              ),
                                            ));
                                      },
                                      icon: Icon(
                                        Icons.music_note,
                                        color: Colors.white,
                                        size: 30.w,
                                      )),
                                );
                              },
                            ),
                            SizedBox(
                              width: 35.w,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchScreen(
                                          audiosongs: widget.audiosongs,
                                        ),
                                      ));
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30.w,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
