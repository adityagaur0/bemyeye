import 'package:audioplayers/audioplayers.dart';
import 'package:bemyeye/src/constants/text_strings.dart';
import 'package:bemyeye/src/service/tts_service.dart';
import 'package:flutter/material.dart';

class TextReadHelp extends StatefulWidget {
  const TextReadHelp({super.key});

  @override
  State<TextReadHelp> createState() => _TextReadHelpState();
}

class _TextReadHelpState extends State<TextReadHelp> {
  final TTSService ttsService = TTSService();
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    ttsService.speak(readtext);
    // player.play(AssetSource("sounds/ReadText.mp3"));
  }

  @override
  void dispose() {
    ttsService.stop(); // Stop any ongoing speech
    //flutterTts.shutdown(); // Release FlutterTts resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // player.stop();
        Navigator.pop(context); //CLose THe bottom modal manually
      },
      onDoubleTap: () {
        ttsService.speak(readtext);
      },
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    "Read Text",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(80, 0, 0, 0),
                    child: TextButton(
                      onPressed: () {
                        // player.stop();
                        Navigator.pop(
                            context); //CLose THe bottom modal manually
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Text(
                  "Hold the camera over some text and double tap on the screen to read out loud. To repeat this again double tap and to exit this introduction single tap.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
