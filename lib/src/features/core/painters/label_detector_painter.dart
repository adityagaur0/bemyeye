import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:icansee/src/service/tts_service.dart';

class LabelDetectorPainter extends CustomPainter {
  final List<ImageLabel> labels;
  // final TTSService ttsService = TTSService();
  final TTSService ttsService;
  String? lastSpokenLabel;

  LabelDetectorPainter(
    this.labels,
    this.ttsService,
  ) {
    // _speakLabels();
  }

  // _speakLabels() {
  //   for (final ImageLabel label in labels) {
  //     final currentLabel = label.label;
  //     if (currentLabel != lastSpokenLabel) {
  //       ttsService.speak(currentLabel);
  //       lastSpokenLabel = currentLabel;
  //     }

  //     // Add a small delay before speaking the next label
  //     // await Future.delayed(const Duration(seconds: 1));
  //   }
  // }

  @override
  void paint(Canvas canvas, Size size) {
    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: 23,
        textDirection: TextDirection.ltr,
      ),
    );

    builder.pushStyle(
        ui.TextStyle(color: const ui.Color.fromARGB(255, 193, 208, 220)));
    for (final ImageLabel label in labels) {
      builder.addText(
          'Label: ${label.label}, Confidence: ${label.confidence.toStringAsFixed(2)}\n');
    }
    builder.pop();

    canvas.drawParagraph(
      builder.build()
        ..layout(ui.ParagraphConstraints(
          width: size.width,
        )),
      const Offset(0, 0),
    );
  }

  @override
  bool shouldRepaint(LabelDetectorPainter oldDelegate) {
    return oldDelegate.labels != labels;
  }
}
