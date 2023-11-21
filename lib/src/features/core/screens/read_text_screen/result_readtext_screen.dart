import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';

class ResultReadTextScreen extends StatefulWidget {
  final String textstring;

  const ResultReadTextScreen({Key? key, required this.textstring})
      : super(key: key);

  @override
  State<ResultReadTextScreen> createState() => _ResultReadTextScreenState();
}

class _ResultReadTextScreenState extends State<ResultReadTextScreen> {
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
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Lottie.asset('assets/lottie/womenTalk.json',
                          width: 250)),
                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.textstring,
                      softWrap: false,
                      style: const TextStyle(
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
