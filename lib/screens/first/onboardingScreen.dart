import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/screens/home%20screens/homescreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:music_player/model/box-instance.dart';

class onboardingScreen extends StatefulWidget {
  const onboardingScreen({Key? key}) : super(key: key);

  @override
  State<onboardingScreen> createState() => _onboardingScreenState();
}

class _onboardingScreenState extends State<onboardingScreen> {
  final box = boxes.getinstance();
  final assetAudioPlayer = AssetsAudioPlayer.withId("0");
  List<Audio> audiosongs = [];
  final _audioquery = OnAudioQuery();
  List<Songs> mappedsongs = [];
  List<Songs> databaseSong = [];
  List<SongModel> fetchedsong = [];
  @override
  void initState() {
    super.initState();
    fetchingsongs();
  }

  @override
  void dispose() {
    _audioquery;
    audiosongs;
    fetchingsongs();
    super.dispose();
  }

  Future<void> _navigatetoMain() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: ((context) => MainScreen(audiosongs: audiosongs))));
  }

  List<SongModel> allSongs = [];

  fetchingsongs() async {
    bool ispermission = await _audioquery.permissionsStatus();
    if (!ispermission) {
      await _audioquery.permissionsRequest();
    }

    allSongs = await _audioquery.querySongs();

    mappedsongs = allSongs
        .map((e) => Songs(
            title: e.title,
            artist: e.artist,
            id: e.id,
            duration: e.duration,
            uri: e.uri!))
        .toList();

    await box.put("musics", mappedsongs);
    databaseSong = box.get("musics") as List<Songs>;

    databaseSong.forEach((element) {
      audiosongs.add(Audio.file(element.uri.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist)));
    });

    _navigatetoMain();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var mediaQuery1 = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        // height: height * 1.h,
        width: width * 1.w,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/onboard.jpg'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Music',
                style: TextStyle(
                    // fontFamily: "poppinz",
                    fontWeight: FontWeight.bold,
                    fontSize: 50.sp,
                    color: Colors.white),
              ),
              SizedBox(height: 10.h),
              Text(
                'Heals',
                style: TextStyle(
                    // fontFamily: "poppinz",
                    fontWeight: FontWeight.bold,
                    fontSize: 50.sp,
                    color: Colors.white),
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: GradientText(
                  'Everything',
                  style: TextStyle(
                      // fontFamily: "poppinz",
                      fontWeight: FontWeight.bold,
                      fontSize: 50.sp),
                  colors: const [
                    Color.fromARGB(255, 214, 22, 8),
                    Color.fromARGB(255, 100, 16, 16),
                    Color.fromARGB(255, 214, 56, 44)
                  ],
                ),
              ),
              //  SizedBox(
              //   height: 510.h,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Container(
                      height: height * .06.h,
                      width: 250.w,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 233, 160),
                              Colors.white
                            ],
                          ),
                          borderRadius: BorderRadius.circular(40)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          onSurface: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          minimumSize: const Size(100, 40),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MainScreen(audiosongs: audiosongs)));
                        },
                        child: Text('Lets Heal..',
                            style: TextStyle(
                                fontFamily: "poppinz",
                                fontSize: 25.h,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
