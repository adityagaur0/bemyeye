// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:icansee/src/features/core/controllers/camera_controller.dart';
// import 'package:icansee/src/service/tts_service.dart';

// class TextRecognitionScreen extends StatefulWidget {
//   const TextRecognitionScreen(
//       {super.key, required this.resultPageBuilder, required this.ttext});
//   final Widget Function(String text) resultPageBuilder;
//   final String ttext;

//   @override
//   State<TextRecognitionScreen> createState() => _TextRecognitionScreenState();
// }

// class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
//   final TTSService ttsService = TTSService();
//   final textRecognizer = TextRecognizer();
//   late final CameraManager _cameraManager;
//   bool _isCameraInitializing = false;

//   @override
//   void initState() {
//     super.initState();
//     ttsService.speak(widget.ttext);
//     _cameraManager = CameraManager(() {
//       setState(() {}); // Trigger the state update in TextRecognitionScreen
//     });
//   }

//   @override
//   void dispose() {
//     _cameraManager.dispose();
//     textRecognizer.close();
//     ttsService.stop();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _cameraManager.future,
//       builder: (context, snapshot) {
//         return InkWell(
//           onDoubleTap: _scanImage,
//           child: Stack(
//             children: [
//               if (_cameraManager.isPermissionGranted)
//                 FutureBuilder<List<CameraDescription>>(
//                   future: availableCameras(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       if (!_isCameraInitializing) {
//                         _isCameraInitializing = true;
//                         _cameraManager.initCameraController(snapshot.data!);
//                       }

//                       return Center(
//                         child: CameraPreview(_cameraManager.cameraController!),
//                       );
//                     } else {
//                       return const LinearProgressIndicator();
//                     }
//                   },
//                 ),
//               Scaffold(
//                 backgroundColor: _cameraManager.isPermissionGranted
//                     ? Colors.transparent
//                     : null,
//                 body: _cameraManager.isPermissionGranted
//                     ? Column(
//                         children: [
//                           Expanded(
//                             child: Container(),
//                           ),
//                           // Container(
//                           //   padding: const EdgeInsets.only(bottom: 30.0),
//                           //   child: Center(
//                           //     child: ElevatedButton(
//                           //       onPressed: _scanImage,
//                           //       child: const Text('Scan text'),
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       )
//                     : Center(
//                         child: Container(
//                           padding:
//                               const EdgeInsets.only(left: 24.0, right: 24.0),
//                           child: const Text(
//                             'Camera permission denied',
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _scanImage() async {
//     if (_cameraManager.cameraController == null) return;

//     final navigator = Navigator.of(context);

//     try {
//       final pictureFile = await _cameraManager.cameraController!.takePicture();

//       final file = File(pictureFile.path);

//       final inputImage = InputImage.fromFile(file);

//       final recognizedText = await textRecognizer.processImage(inputImage);

//       await navigator.push(
//         MaterialPageRoute(
//           builder: (BuildContext context) =>
//               widget.resultPageBuilder(recognizedText.text),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('An error occurred when scanning text'),
//         ),
//       );
//     }
//   }
// }
