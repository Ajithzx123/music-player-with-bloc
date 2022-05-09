import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/model/box-instance.dart';
import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/openAudio/openaudio.dart';
import 'package:music_player/screens/Nowplaying/NowPlaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../logic/bloc/search_bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  List<Audio> audiosongs = [];
  SearchScreen({Key? key, required this.audiosongs}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Songs> dbSongs = [];
  List<Audio> allSongs = [];

  String search = "";

  final box = boxes.getinstance();

  @override
  void initState() {
    super.initState();
    // getSongs();
  }

  //  getSongs() {
  //   dbSongs = box.get("musics") as List<Songs>;
  //   for (var element in dbSongs) {
  //     allSongs.add(
  //       Audio.file(
  //         element.uri.toString(),
  //         metas: Metas(
  //           title: element.title,
  //           id: element.id.toString(),
  //           artist: element.artist,
  //         ),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // List<Audio> searchResult = allSongs
    //     .where(
    //       (element) => element.metas.title!.toLowerCase().startsWith(
    //             search.toLowerCase(),
    //           ),
    //     )
    //     .toList();

    return ScaffoldGradientBackground(
      gradient: const LinearGradient(colors: [
        Color.fromARGB(255, 31, 56, 77),
        const Color.fromARGB(255, 75, 11, 7)
      ]),
      body: SafeArea(
        // ignore: avoid_unnecessary_containers
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black26)]),
                height: 50.h,
                width: 330.w,
                child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14),
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      hintText: 'search a song',
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value) {
                      search = value;
                      context
                          .read<SearchBloc>()
                          .add(EnterInputEvent(searchInput: value));
                    }),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                List<Audio> searchResult = state.props as List<Audio>;
                return search.isNotEmpty
                    ? searchResult.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: searchResult.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      OpenAssetAudio(
                                              allsong: searchResult,
                                              index: index)
                                          .openAsset(
                                              index: index,
                                              audios: searchResult);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PlayingSCreen(
                                                    // index: index,

                                                    audioSongs:
                                                        widget.audiosongs,
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: SizedBox(
                                        height: 45.h,
                                        width: 45.w,
                                        child: QueryArtworkWidget(
                                          id: int.parse(
                                              searchResult[index].metas.id!),
                                          type: ArtworkType.AUDIO,
                                          artworkBorder:
                                              BorderRadius.circular(15),
                                          artworkFit: BoxFit.cover,
                                          nullArtworkWidget: Container(
                                            height: 45.h,
                                            width: 45.w,
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
                                        searchResult[index].metas.title!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: "poppinz",
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 17.sp),
                                      ),
                                      subtitle: Text(
                                        searchResult[index].metas.artist!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: "poppinz",
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Padding(
                            padding: EdgeInsets.all(30),
                            child: Text(
                              "No result found",
                              style: TextStyle(
                                fontFamily: "poppinz",
                                fontSize: 17.sp,
                                color: Colors.white,
                              ),
                            ),
                          )
                    : const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
