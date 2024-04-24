import 'package:icansee/src/features/activity_indicator/activity_indicator.dart';
import 'package:flutter/material.dart' hide Ink;
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:icansee/src/service/tts_service.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  final TTSService ttsService = TTSService();
  final DigitalInkRecognizerModelManager _modelManager =
      DigitalInkRecognizerModelManager();
  var _language = 'en';

  final _languages = [
    'en',
    'hi',
  ];
  var _digitalInkRecognizer = DigitalInkRecognizer(languageCode: 'en');
  final Ink _ink = Ink();
  List<StrokePoint> _points = [];
  String _recognizedText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _digitalInkRecognizer.close();
    ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InkWell(
          onTap: _clearPad,
          onDoubleTap: _recogniseText,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDropdown(),
                    ElevatedButton(
                      onPressed: _isModelDownloaded,
                      child: const Text('Check Model'),
                    ),
                    ElevatedButton(
                      onPressed: _downloadModel,
                      child: const Icon(Icons.download),
                    ),
                    ElevatedButton(
                      onPressed: _deleteModel,
                      child: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 8),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       ElevatedButton(
              //         onPressed: _recogniseText,
              //         child: const Text('Read Text'),
              //       ),
              //       ElevatedButton(
              //         onPressed: _clearPad,
              //         child: const Text('Clear Pad'),
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: GestureDetector(
                  onPanStart: (DragStartDetails details) {
                    _ink.strokes.add(Stroke());
                  },
                  onPanUpdate: (DragUpdateDetails details) {
                    setState(() {
                      final RenderObject? object = context.findRenderObject();
                      var localPosition = (object as RenderBox?)
                          ?.globalToLocal(details.localPosition);

                      if (localPosition != null) {
                        localPosition =
                            Offset(localPosition.dx, localPosition.dy + 70.0);
                        _points = List.from(_points)
                          ..add(StrokePoint(
                            x: localPosition.dx,
                            y: localPosition.dy,
                            t: DateTime.now().millisecondsSinceEpoch,
                          ));
                      }
                      if (_ink.strokes.isNotEmpty) {
                        _ink.strokes.last.points = _points.toList();
                      }
                    });
                  },
                  onPanEnd: (DragEndDetails details) {
                    _points.clear();
                    setState(() {});
                  },
                  child: CustomPaint(
                    painter: Signature(ink: _ink),
                    size: Size.infinite,
                  ),
                ),
              ),
              if (_recognizedText.isNotEmpty)
                Text(
                  //_recognizedText[0],
                  _recognizedText,
                  style: const TextStyle(fontSize: 23),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() => DropdownButton<String>(
        value: _language,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.blue),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (String? lang) {
          if (lang != null) {
            setState(() {
              _language = lang;
              _digitalInkRecognizer.close();
              _digitalInkRecognizer =
                  DigitalInkRecognizer(languageCode: _language);
            });
          }
        },
        items: _languages.map<DropdownMenuItem<String>>((lang) {
          return DropdownMenuItem<String>(
            value: lang,
            child: Text(lang),
          );
        }).toList(),
      );

  void _clearPad() {
    setState(() {
      ttsService.speak("Pad Cleared");
      _ink.strokes.clear();
      _points.clear();
      _recognizedText = '';
    });
  }

  Future<void> _isModelDownloaded() async {
    Toast().show(
        'Checking if model is downloaded...',
        _modelManager
            .isModelDownloaded(_language)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _deleteModel() async {
    Toast().show(
        'Deleting model...',
        _modelManager
            .deleteModel(_language)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _downloadModel() async {
    Toast().show(
        'Downloading model...',
        _modelManager
            .downloadModel(_language)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _recogniseText() async {
    // awaitttsService.speak('Recognizing');
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text('Recognizing'),
            ),
        barrierDismissible: true);
    try {
      final candidates = await _digitalInkRecognizer.recognize(_ink);
      _recognizedText = '';
      for (final candidate in candidates) {
        _recognizedText += '\n${candidate.text}';
        break;
      }

      ttsService.speak(_recognizedText);
      setState(() {});
    } catch (e) {
      ttsService.speak('failed');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
    Navigator.pop(context);
  }
}

class Signature extends CustomPainter {
  Ink ink;

  Signature({required this.ink});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (final stroke in ink.strokes) {
      for (int i = 0; i < stroke.points.length - 1; i++) {
        final p1 = stroke.points[i];
        final p2 = stroke.points[i + 1];
        canvas.drawLine(Offset(p1.x.toDouble(), p1.y.toDouble()),
            Offset(p2.x.toDouble(), p2.y.toDouble()), paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => true;
}
