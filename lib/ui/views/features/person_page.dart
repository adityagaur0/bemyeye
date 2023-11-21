import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PersonInfoPage extends StatefulWidget {
  const PersonInfoPage({super.key});

  @override
  State<PersonInfoPage> createState() => _PersonInfoPageState();
}

class _PersonInfoPageState extends State<PersonInfoPage> {
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    player.play(AssetSource("sounds/Person.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Person"));
  }
}
