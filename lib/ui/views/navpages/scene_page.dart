import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ScenePage extends StatefulWidget {
  const ScenePage({super.key});

  @override
  State<ScenePage> createState() => _ScenePageState();
}

class _ScenePageState extends State<ScenePage> {
  final player = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.play(AssetSource("sounds/ReadTextClip.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("Scene Page")),
    );
  }
}
