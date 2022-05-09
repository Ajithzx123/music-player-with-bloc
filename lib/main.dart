import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/logic/bloc/fav_block/favourite_bloc.dart';
import 'package:music_player/logic/bloc/search_bloc/search_bloc.dart';
import 'package:music_player/logic/cubit/cubit_player/player_cubit.dart';
import 'package:music_player/model/box-instance.dart';
import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/screens/first/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences preferences;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());

  await Hive.openBox<List>(boxname);
  final box = boxes.getinstance();

  preferences = await SharedPreferences.getInstance();
  preferences.setBool('isPlaying', false);

  List<dynamic> libraryKeys = box.keys.toList();

  if (!libraryKeys.contains("favorites")) {
    List<dynamic> likedSongs = [];
    await box.put("favorites", likedSongs);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 780),
        minTextAdapt: true,
        splitScreenMode: true,
         builder: ()  =>  MultiBlocProvider(
           providers: [
             BlocProvider(
               create: (context) => PlayerCubit(),
             ),
             BlocProvider(
               create: (context) => SearchBloc(),
             ),
             BlocProvider(
               create: (context) => FavouriteBloc(),
             ),
           ],
         
         
           child: MaterialApp(
                    debugShowCheckedModeBanner: false, home: Splash()),
         ),
            );
  }
}
