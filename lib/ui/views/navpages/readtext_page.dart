import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class ReadTextPage extends StatefulWidget {
  const ReadTextPage({super.key});

  @override
  State<ReadTextPage> createState() => _ReadTextPageState();
}

class _ReadTextPageState extends State<ReadTextPage>
    with WidgetsBindingObserver {
  bool _isPermissionGranted = false;
  late final Future<void> _future;
  CameraController? _cameraController;
  final textRecognizer = TextRecognizer();

  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    player.play(AssetSource("sounds/ReadTextClip.mp3"));
    WidgetsBinding.instance.addObserver(this);
    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        //finally add camera to the tree
        //we added scaffold behind the stack because,
        //empty bands will be seen around it,
        //considering the camera has same aspect ratio as mobile
        return GestureDetector(
          onDoubleTap: _scanImage,
          child: Stack(
            children: [
              if (_isPermissionGranted)
                FutureBuilder<List<CameraDescription>>(
                  future: availableCameras(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _initCameraController(snapshot.data!);

                      return Center(child: CameraPreview(_cameraController!));
                    } else {
                      return const LinearProgressIndicator(); // to show camera is not granted
                    }
                  },
                ),
              Scaffold(
                backgroundColor:
                    _isPermissionGranted ? Colors.transparent : null,
                body: _isPermissionGranted
                    ? Column(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Center(
                                // child: ElevatedButton(
                                //   onPressed: _scanImage,
                                //   child: const Text('Scan text'),
                                // ),
                                ),
                          ),
                        ],
                      )
                    : Center(
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          child: const Text(
                            'Camera permission denied',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  //method to open the camera
  void _startCamera() {
    //very imp to check weather camera controller is not null.
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  //method to close the camera
  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

//method to initalise the camera controller
  void _initCameraController(List<CameraDescription> cameras) {
    //we check the _cameracontroller variable is not already intialised.
    if (_cameraController != null) {
      return; // if so we exit the method
    }

    //select which camera we want
    //iterate all the cameras and choose the first camera which point backward.
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    //pass to another method
    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  // responsible to initalise the camera already defined
  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset
          .max, // set resolution to maximum that will help text detection.
      enableAudio: false,
    );

    // asynchronus method to perform initalization
    await _cameraController!.initialize();
    await _cameraController!.setFlashMode(FlashMode.off);

    // incharget of refreshing the state in order to show already intialized camera.

    if (!mounted) {
      return;
    }
    setState(() {});
  }

//scan image
  Future<void> _scanImage() async {
    //first check camera contrller is not null
    if (_cameraController == null) return;

    //to direct the user to result screen
    final navigator = Navigator.of(context);

    try {
      //obtain picture from camera
      final pictureFile = await _cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);

      final recognizedText =
          await textRecognizer.processImage(inputImage); //google ml kit

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ResultScreen(textstring: recognizedText.text),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}

class ResultScreen extends StatefulWidget {
  final String textstring;

  ResultScreen({Key? key, required this.textstring}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1); // 0.5 to 1.5
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    speak(widget
        .textstring); // Automatically start speaking when the screen is initialized
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Result'),
          ),
          body: Container(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Lottie.asset('assets/lottie/womenTalk.json',
                          width: 250)),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.textstring,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 13, // Change the font size as needed
                        fontWeight: FontWeight
                            .normal, // Change the font weight as needed
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),

                  // ElevatedButton(
                  //   onPressed: () => speak(widget.textstring),
                  //   child: Text("Start Text to Speech"),
                  // ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    flutterTts.stop(); // Stop any ongoing speech
    //flutterTts.shutdown(); // Release FlutterTts resources
    super.dispose();
  }
}
