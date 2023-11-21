import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:bemyeye/src/views/features/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    startTimer();
    player.play(AssetSource("sounds/welcome.mp3"));
  }

  startTimer() {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    player.stop();
    Navigator.pushReplacement(context,
        PageTransition(child: const Home(), type: PageTransitionType.fade));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/welcome.json'),
            Lottie.asset('assets/lottie/welcome2.json', width: 250),
          ],
        ),
      ),
    );
  }
}


// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => Home()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Text(
//           "TAXIFY",
//           style: TextStyle(
//               fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
