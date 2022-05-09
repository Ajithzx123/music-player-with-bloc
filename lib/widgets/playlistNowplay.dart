import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/model/box-instance.dart';
import 'package:music_player/widgets/snackbar.dart';

import '../model/hivemodel.dart';

class PlaylistNow extends StatelessWidget {
  PlaylistNow({Key? key, required this.song}) : super(key: key);
  Audio song;

  List playlists = [];
  String? playlistName = '';
  List<dynamic>? playlistSongs = [];
  @override
  Widget build(BuildContext context) {
    final box = boxes.getinstance();
    playlists = box.keys.toList();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 83, 17, 12),
            Color.fromARGB(255, 70, 63, 7)
          ]),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: ListTile(
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                  backgroundColor: const Color.fromARGB(255, 73, 67, 67),
                  title:  Text("Add new Playlist",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "poppinz",
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold)),
                  content: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(30)),
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 202, 202, 202)),
                      hintText: 'Create a Playlist',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 155, 122, 122),
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      playlistName = value;
                    },
                    autofocus: true,
                    cursorRadius: const Radius.circular(50),
                    cursorColor: Colors.grey,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          List<Songs> librayry = [];
                          List? excistingName = [];
                          if (playlists.isNotEmpty) {
                            excistingName = playlists
                                .where((element) => element == playlistName)
                                .toList();
                          }

                          if (playlistName != '' && excistingName.isEmpty) {
                            box.put(playlistName, librayry);
                            Navigator.of(context).pop();
                            playlists = box.keys.toList();
                          } else {
                             Navigator.of(context).pop();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBars().excistingPlaylist);
                          }

                          // controller.clear();
                        },
                        child:  Text(
                          "ADD",
                          style: TextStyle(
                            fontFamily: "poppinz",
                            color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold
                          ),
                        ))
                  ],
                ),
              ),
              leading:  Icon(
                Icons.add,
                color: Colors.white,
                size: 23.w,
              ),
              title:  Text(
                "Create Playlist",
                style: TextStyle(
                  fontFamily: "poppinz",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.sp),
              ),
            ),
          ),
          ...playlists
              .map((e) => e != "musics" && e != "favorites"
                  ? libraryList(
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Container(
                        height: 75.h,
                        width: 95.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: ListTile(
                            onTap: () async {
                              playlistSongs = box.get(e);
                              List existingSongs = [];
                              existingSongs = playlistSongs!
                                  .where((element) =>
                                      element.id.toString() ==
                                      song.metas.id.toString())
                                  .toList();

                              if (existingSongs.isEmpty) {
                                final songs = box.get("musics") as List<Songs>;
                                final temp = songs.firstWhere((element) =>
                                    element.id.toString() ==
                                    song.metas.id.toString());
                                playlistSongs?.add(temp);

                                await box.put(e, playlistSongs!);

                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBars().songAdded);
                              } else {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBars().excistingSong);
                              }
                            },
                            leading: Container(
                              height: 45.h,
                              width: 45.w,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 154, 142, 142),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Icon(
                                Icons.queue,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              e.toString(),
                              style:  TextStyle(
                                fontFamily: "poppinz",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15.sp),
                            ),
                          ),
                        ),
                      ),
                    ))
                  : Container())
              .toList()
        ],
      ),
    );
  }

  Padding libraryList({required child}) {
    return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: child);
  }
}
