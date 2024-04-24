import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:icansee/src/features/core/controllers/camera_controller.dart';
import 'package:icansee/src/features/core/screens/04recognition/05object_recognition/object_recognition_result.dart';
import 'package:icansee/src/features/core/screens/04recognition/utils.dart';
import 'package:icansee/src/service/tts_service.dart';

class CombinedRecognitionScreen extends StatefulWidget {
  const CombinedRecognitionScreen(
      {Key? key, // Added the 'Key?' parameter
      required this.resultPageBuilder,
      required this.recognitionType,
      required this.ttext})
      : super(key: key);

  final Widget Function(String text) resultPageBuilder;
  final RecognitionType recognitionType;
  final String ttext;

  @override
  State<CombinedRecognitionScreen> createState() =>
      _CombinedRecognitionScreenState();
}

class _CombinedRecognitionScreenState extends State<CombinedRecognitionScreen> {
  final textRecognizer = TextRecognizer();
  late final CameraManager _cameraManager;
  bool _isCameraInitializing = false;
  late ImageLabeler _imageLabeler;
  bool _canProcess = false;
  String? _text;
  bool _isBusy = false;
  final TTSService ttsService = TTSService();

  @override
  void initState() {
    super.initState();
    ttsService.speak(widget.ttext);
    _cameraManager = CameraManager(() {
      setState(() {});
    });
    _initializeLabeler();
  }

  @override
  void dispose() {
    _cameraManager.dispose();
    _canProcess = false;
    _imageLabeler.close();
    textRecognizer.close();
    ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cameraManager.future,
      builder: (context, snapshot) {
        return InkWell(
          onDoubleTap: widget.recognitionType == RecognitionType.Text
              ? _scanImage
              : _detectObject,
          child: Stack(
            children: [
              if (_cameraManager.isPermissionGranted)
                FutureBuilder<List<CameraDescription>>(
                  future: availableCameras(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (!_isCameraInitializing) {
                        _isCameraInitializing = true;
                        _cameraManager.initCameraController(snapshot.data!);
                      }

                      return Center(
                        child: CameraPreview(_cameraManager.cameraController!),
                      );
                    } else {
                      return const LinearProgressIndicator();
                    }
                  },
                ),
              Scaffold(
                backgroundColor: _cameraManager.isPermissionGranted
                    ? Colors.transparent
                    : null,
                body: _cameraManager.isPermissionGranted
                    ? Column(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          // Container(
                          //   padding: const EdgeInsets.only(bottom: 30.0),
                          //   child: Center(
                          //     child: ElevatedButton(
                          //       onPressed: widget.recognitionType ==
                          //               RecognitionType.Text
                          //           ? _scanImage
                          //           : _detectObject,
                          //       child: Text(widget.recognitionType ==
                          //               RecognitionType.Text
                          //           ? 'Scan text'
                          //           : 'Detect object'),
                          //     ),
                          //   ),
                          // ),
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

  Future<void> _scanImage() async {
    if (_cameraManager.cameraController == null) return;

    final navigator = Navigator.of(context);

    try {
      final pictureFile = await _cameraManager.cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);

      final recognizedText = await textRecognizer.processImage(inputImage);

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              widget.resultPageBuilder(recognizedText.text),
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

  void _initializeLabeler() async {
    const path = 'assets/ML/object_labeler.tflite';
    final modelPath = await getAssetPath(path);
    final options = LocalLabelerOptions(modelPath: modelPath);
    _imageLabeler = ImageLabeler(options: options);

    _canProcess = true;
  }

  Future<void> _detectObject() async {
    if (_cameraManager.cameraController == null) return;

    final navigator = Navigator.of(context);

    try {
      final pictureFile = await _cameraManager.cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      if (!_canProcess) return;
      if (_isBusy) return;
      _isBusy = true;
      setState(() {
        _text = '';
      });

      final labels = await _imageLabeler.processImage(inputImage);
      String text = 'Object found: ${labels.length}\n\n';
      for (final label in labels) {
        text += 'Label: ${label.label}\n\n';
        //'Confidence: ${label.confidence.toStringAsFixed(2)}\n\n';
      }
      _text = text;
      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) => ObjectResultScreen(text: text),
        ),
      );
      _isBusy = false;
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}

enum RecognitionType {
  Text,
  Object,
}
