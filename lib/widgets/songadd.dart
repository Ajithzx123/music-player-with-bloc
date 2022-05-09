import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/logic/cubit/cubit_player/player_cubit.dart';
import 'package:music_player/model/box-instance.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../model/hivemodel.dart';

// ignore: must_be_immutable
class songadd extends StatefulWidget {
  String playlistName;
  songadd({Key? key, required this.playlistName}) : super(key: key);

  @override
  _buildSheetState createState() => _buildSheetState();
}

class _buildSheetState extends State<songadd> {
  final box = boxes.getinstance();

  List<Songs> dbSongs = [];
  List<Songs> playlistSongs = [];
  @override
  void initState() {
    super.initState();
    getSongs();
  }

  getSongs() {
    dbSongs = box.get("musics") as List<Songs>;
    playlistSongs = box.get(widget.playlistName)!.cast<Songs>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 83, 17, 12),
              Color.fromARGB(255, 70, 63, 7)
            ]),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        // color: Colors.grey,
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
        child: ListView.builder(
          itemCount: dbSongs.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Container(
                    height: 45.w,
                    width: 45.w,
                    child: QueryArtworkWidget(
                      id: dbSongs[index].id!,
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.circular(15),
                      artworkFit: BoxFit.cover,
                      nullArtworkWidget: Container(
                        height: 45.w,
                        width: 45.w,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                            image: AssetImage("assets/unknown.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    dbSongs[index].title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: "poppinz",
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 15.sp),
                  ),
                  trailing: BlocBuilder<PlayerCubit, PlayerCubitState>(
                    builder: (context, state) {
                     
                      return Column(
                       
                        children: [
                       
                          playlistSongs
                                  .where((element) =>
                                      element.id.toString() ==
                                      dbSongs[index].id.toString())
                                  .isEmpty
                              ? IconButton(
                                  onPressed: () async {
                                    playlistSongs.add(dbSongs[index]);
                                    await box.put(
                                        widget.playlistName, playlistSongs);
                                    context
                                        .read<PlayerCubit>()
                                        .changeIcon(Icons.add);
                                    
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ))
                              : IconButton(
                                  onPressed: () async {
                                   

                                    playlistSongs.removeWhere((elemet) =>
                                        elemet.id.toString() ==
                                        dbSongs[index].id.toString());

                                    await box.put(
                                        widget.playlistName, playlistSongs);
                                    context
                                        .read<PlayerCubit>()
                                        .changeIcon(Icons.remove);


                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  )),
                                  
                        ],
                        
                      );
                    },
                  ),
                ));
          },
        ));
  }
}
