import 'package:audioplayers/audioplayers.dart';
import 'package:bemyeye/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ReadTextPage extends StatefulWidget {
  const ReadTextPage({super.key});

  @override
  State<ReadTextPage> createState() => _ReadTextPageState();
}

class _ReadTextPageState extends State<ReadTextPage> {
  late CameraController Controller;
  final player = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCamera();
    player.play(AssetSource("sounds/ReadTextClip.mp3"));
  }

  loadCamera() {
    Controller = CameraController(cameras[0], ResolutionPreset.max);
    Controller.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {});
      }
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!Controller.value.isInitialized) {
      return Container();
    }
    return CameraPreview(Controller);
  }
}
