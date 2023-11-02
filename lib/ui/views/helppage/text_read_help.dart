
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextReadHelp extends StatefulWidget {
  const TextReadHelp({super.key});

  @override
  State<TextReadHelp> createState() => _TextReadHelpState();
}

class _TextReadHelpState extends State<TextReadHelp> {
  final FlutterTts flutterTts = FlutterTts();
  final player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.play(AssetSource("sounds/ReadText.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
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
                        player.stop();
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
                  "Hold the camera over some text to have it automatically read to you. As new text comes into view, it will also be read out loud.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Text(
                  " While reading out loud, Seeing Al may start again from the beginning if the camera captures a clearer image of the text.",
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
