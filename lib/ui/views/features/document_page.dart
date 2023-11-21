import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    player.play(AssetSource("sounds/document.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Document"));
  }
}
