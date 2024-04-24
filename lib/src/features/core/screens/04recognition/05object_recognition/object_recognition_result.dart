import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:icansee/src/constants/lottie_string.dart';
import 'package:lottie/lottie.dart';

class ObjectResultScreen extends StatefulWidget {
  final String text;

  const ObjectResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  _ObjectResultScreenState createState() => _ObjectResultScreenState();
}

class _ObjectResultScreenState extends State<ObjectResultScreen> {
  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1); // 0.5 to 1.5
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    widget.text == ""
        ? speak("No text to read")
        : speak("${widget.text}To exit the screen Single tap"); // Automatically start speaking when the screen is initialized
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
                  Center(child: Lottie.asset(lobjectRecognition, width: 250)),
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
                    child: widget.text == ""
                        ? const Text(
                            "No Text To Read",
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 13, // Change the font size as needed
                              fontWeight: FontWeight
                                  .normal, // Change the font weight as needed
                              color: Colors.black, // Text color
                            ),
                          )
                        : Text(
                            widget.text,
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
