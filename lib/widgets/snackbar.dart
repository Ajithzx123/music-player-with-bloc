import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBars {
  final excistingPlaylist = SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    content:  Text(
      'Excisting playlist name',
      style: TextStyle(
          fontFamily: "poppinz", fontSize: 15.sp, fontWeight: FontWeight.bold),
    ),
    backgroundColor: const Color.fromARGB(255, 141, 8, 8),
  );
  final excistingSong = SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    content:  Text(
      'Song already exists',
      style: TextStyle(
          fontFamily: "poppinz", fontSize: 15.sp, fontWeight: FontWeight.bold),
    ),
    backgroundColor: const Color.fromARGB(255, 141, 8, 8),
  );
  final songAdded = SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    content:  Text(
      'Song added to Playlist',
      style: TextStyle(
          fontFamily: "poppinz", fontSize: 15.sp, fontWeight: FontWeight.bold),
    ),
    backgroundColor: const Color.fromARGB(255, 141, 8, 8),
  );
  final likedAdd = SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    content:  Text(
      'Song added to Favorites',
      style:  TextStyle(
          fontFamily: "poppinz", fontSize: 15.sp, fontWeight: FontWeight.bold),
    ),
    backgroundColor: const Color.fromARGB(255, 141, 8, 8),
  );
  final likedRemove = SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    content:  Text(
      'Song removed from Favorites',
      style: TextStyle(
          fontFamily: "poppinz", fontSize: 15.sp, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.grey[900],
  );

  final NoPlaying = SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    content:  Text(
      'Currently no song is playing',
      style: TextStyle(
          fontFamily: "poppinz", fontSize: 15.sp, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.grey[900],
  );
   final notifsnack = SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    content:  Text(
      'Please restart your app to see changes',
      style:  TextStyle(
          fontFamily: "poppinz", fontSize: 15.sp, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Color.fromARGB(255, 44, 44, 44),
  );
}
