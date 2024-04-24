// import 'package:flutter_tts/flutter_tts.dart';

// class TTSService {
//   final FlutterTts flutterTts = FlutterTts();
//   Future<void> speak(String text) async {
//     try {
//       await flutterTts.setLanguage("en-us");
//       await flutterTts.setPitch(1.0); // 0.5 to 1.5 // pitch of sound
//       await flutterTts.setVolume(1.0); // volume of speech
//       await flutterTts.setSpeechRate(0.4); // speed of speech
//       await flutterTts.speak(text);
//     } catch (e) {
//       print("Error in TTS: $e");
//     }
//   }

//   stop() async {
//     flutterTts.stop();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSService with WidgetsBindingObserver {
  final FlutterTts flutterTts = FlutterTts();

  TTSService() {
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-us");
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(text);
  }

  void stop() {
    flutterTts.stop();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        // The app is in the background, stop TTS if it's speaking.
        stop();
        break;
      case AppLifecycleState.resumed:

        // The app is in the foreground.
        break;
      case AppLifecycleState.inactive:
        // The app is inactive (between paused and resumed).
        break;
      case AppLifecycleState.detached:
        // The app is detached (terminated).
        break;
      default:
      // Handle any future AppLifecycleState additions.
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    flutterTts.stop();
  }
}
