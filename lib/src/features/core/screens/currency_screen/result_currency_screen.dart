import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ResultCurrencyScreen extends StatefulWidget {
  final String text;

  const ResultCurrencyScreen({Key? key, required this.text}) : super(key: key);

  @override
  _ResultCurrencyScreenState createState() => _ResultCurrencyScreenState();
}

class _ResultCurrencyScreenState extends State<ResultCurrencyScreen> {
  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1); // 0.5 to 1.5
    await flutterTts.speak(text);
  }

  late String resultMessage;

  @override
  void initState() {
    super.initState();
    determineResultMessage();
    speak(resultMessage);
  }

  void determineResultMessage() {
    if (widget.text.contains("500\n")) {
      resultMessage = "Yes for 500";
    } else if (widget.text.contains("100\n")) {
      resultMessage = "Yes for 100";
    } else if (widget.text.contains("10\n")) {
      resultMessage = "Yes for 10";
    } else if (widget.text.contains("50\n")) {
      resultMessage = "Yes for 50";
    } else if (widget.text.contains("200\n")) {
      resultMessage = "Yes for 200";
    } else {
      resultMessage = "Condition not met";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Text(resultMessage),
            ),
            const SizedBox(
              height: 20,
            ),
            // Text(widget.text),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    flutterTts.stop(); // Stop any ongoing speech
    //flutterTts.shutdown(); // Release FlutterTts resources
    super.dispose();
  }
}
