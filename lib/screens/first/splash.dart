import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/screens/first/onboardingScreen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetonext();
  }

  Future<void> _navigatetonext() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => const onboardingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery1 = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/first logo.png'))),
          height: 90.w,
          // child: GradientText("M U Z I Q",
          //     style:
          //         TextStyle(fontFamily: "poppinz", fontSize: 30.w, fontWeight: FontWeight.w700),
          //     colors: const [Colors.red, Color.fromARGB(255, 8, 65, 112)]),
        ),
        GradientText("M U Z I Q",
            style: TextStyle(
                fontFamily: "poppinz",
                fontSize: 30.w,
                fontWeight: FontWeight.w700),
            colors: const [Colors.red, Color.fromARGB(255, 8, 65, 112)])
      ]),
    );
  }
}
