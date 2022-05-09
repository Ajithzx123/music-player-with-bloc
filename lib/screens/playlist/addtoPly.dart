import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToPlay extends StatelessWidget {
  final String aatitle;
  VoidCallback? tap;
   AddToPlay({Key? key, required this.aatitle, this.tap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: tap,
          child: Container(
            
            height: 67.h,
            width: 345.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(0.5),
            ),
            child: Padding(
              
              padding: const EdgeInsets.all(12.0),
              child: Row(
                
                children: [
                  Container(
                    height: 50.w,
                    width: 50.w,
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
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600),
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

