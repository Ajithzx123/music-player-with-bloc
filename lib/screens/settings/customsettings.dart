import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomList extends StatelessWidget {
  final String newtitle;
  final IconData newleading;
  final IconData? newtrailing;
  VoidCallback? tap;

  CustomList(
      {Key? key,
      required this.newtitle,
      required this.newleading,
      this.newtrailing,
      this.tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      title: Text(
        newtitle,
        style:  TextStyle(
            fontFamily: "poppinz",
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp),
      ),
      leading: Icon(
        newleading,
        color: Colors.white,
        size: 27.w,
      ),
    );
  }
}
