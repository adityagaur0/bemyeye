import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts flutterTts = FlutterTts();
  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0); // 0.5 to 1.5 // pitch of sound
    await flutterTts.setVolume(1.0); // volume of speech
    await flutterTts.setSpeechRate(0.4); // speed of speech
    await flutterTts.speak(text);
  }

  stop() async {
    flutterTts.stop();
  }
}
