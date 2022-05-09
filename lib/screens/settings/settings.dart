import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/logic/cubit/cubit_player/player_cubit.dart';
import 'package:music_player/screens/settings/customsettings.dart';
import 'package:music_player/widgets/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notify = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchvalues();
  }

  switchvalues() async {
    notify = context.read<PlayerCubit>().noti(await getswitchstate());
  }

  Future<bool> saveSwitchvalue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    return prefs.setBool("switchState", value);
  }

  Future<bool> getswitchstate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? notify = prefs.getBool("switchState");
    return notify ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 22, 2, 1),
              Color.fromARGB(255, 133, 16, 7)
            ])),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 50, 0, 0),
          child: Column(children: [
            BlocBuilder<PlayerCubit, PlayerCubitState>(
              builder: (context, state) {
                return SwitchListTile(
                    tileColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    title: const Text(
                      'NOTIFICAION',
                      style: TextStyle(
                          fontFamily: "poppinz",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    secondary: Icon(
                      Icons.notifications,
                      size: 27.w,
                      color: Colors.white,
                    ),
                    value: notify,
                    onChanged: (bool value) {
                      notify = context.read<PlayerCubit>().noti(value);
                      saveSwitchvalue(value);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBars().notifsnack);

                    });
              },
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomList(newtitle: 'PRIVACY & POLICY', newleading: Icons.policy),
            SizedBox(
              height: 8.h,
            ),
            CustomList(
                newtitle: 'TERMS & CONDITION', newleading: Icons.summarize),
            SizedBox(
              height: 8.h,
            ),
            ListTile(
              onTap: () {
                Share.share(
                    "Hey, I'm sharing this offline Music player I hope, it will also help you.  Download it!!!");
              },
              title: Text(
                "SHARE THE APP",
                style: TextStyle(
                    fontFamily: "poppinz",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp),
              ),
              leading: Icon(
                Icons.share,
                color: Colors.white,
                size: 27.w,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomList(
              newtitle: 'ABOUT',
              newleading: Icons.info,
              tap: () {
                showAboutDialog(
                    context: context,
                    applicationName: "Muziq",
                    applicationVersion: "1.0",
                    children: [
                      Text(
                          "MuziQ is a offline music player created by Ajith Kumar s")
                    ],
                    applicationIcon: SizedBox(
                      height: 45.h,
                      width: 45.w,
                      child: Image.asset(
                        "assets/logo.jpg",
                        fit: BoxFit.cover,
                      ),
                    ));
              },
            ),
          ]),
        ),
      )),
    );
  }
}
