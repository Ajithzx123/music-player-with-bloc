import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/model/box-instance.dart';
import 'package:music_player/screens/playlist/playlist.dart';

class customplay extends StatelessWidget {
  final String aatitle;
 
  VoidCallback?  tap;
  customplay({Key? key, required this.aatitle, this.tap,}) : super(key: key);

  
 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: tap,
          child: Container(
            height: 90.h,
            width: 350.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.3)),
                    child: Icon(
                      Icons.queue_music,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    aatitle,
                    style:  TextStyle(
                      fontFamily: "poppinz",
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

 final box = boxes.getinstance();

  List playlists = [];

  String? playlistName = '';

// void popup(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (ctx) {
//         return Dialog(
//           backgroundColor: Color.fromARGB(255, 102, 97, 97),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(40.0),
//             child: Container(
//               width: 300,
//               height: 115,
//               child: Column(
//                 children: [
//                   Text('Do you want to delete',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           width: 80,
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   primary: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20))),
//                               onPressed: () {
//                                box.delete(playlists[index]);
//                               },
//                               child: const Text(
//                                 'Delete',
//                                 style: TextStyle(color: Colors.black),
//                               )),
//                         ),
//                         SizedBox(
//                           width: 80,
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   primary: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20))),
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: const Text(
//                                 'Cancel',
//                                 style: TextStyle(color: Colors.black),
//                               )),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
// }
