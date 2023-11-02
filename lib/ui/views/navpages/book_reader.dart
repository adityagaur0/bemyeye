import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BookReader extends StatefulWidget {
  const BookReader({super.key});

  @override
  State<BookReader> createState() => _BookReaderState();
}

class _BookReaderState extends State<BookReader> {
  final player = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.play(AssetSource("sounds/Book.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("Book")),
    );
  }
}
