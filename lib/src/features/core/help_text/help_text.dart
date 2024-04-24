import 'package:audioplayers/audioplayers.dart';

import 'package:icansee/src/service/tts_service.dart';
import 'package:flutter/material.dart';

class HelpText extends StatefulWidget {
  HelpText({super.key, required this.ttstext, required this.ttexthelp});
  String ttstext;
  String ttexthelp;

  @override
  _HelpTextState createState() => _HelpTextState();
}

class _HelpTextState extends State<HelpText> {
  final TTSService ttsService = TTSService();
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    ttsService.speak(widget.ttexthelp);
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
    return InkWell(
      onTap: () {
        // player.stop();
        Navigator.pop(context); // Close the bottom modal manually
      },
      onDoubleTap: () {
        ttsService.speak(widget.ttstext);
      },
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height *
              0.75, // Adjust the height as needed
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.ttstext,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Done"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.ttexthelp,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
