import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';

class ResultReadTextScreen extends StatelessWidget {
  final String textstring;

  ResultReadTextScreen({Key? key, required this.textstring}) : super(key: key);

  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1); // 0.5 to 1.5
    await flutterTts.speak(text);
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
                        width: 250),
                  ),
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
                      textstring,
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
                  //   onPressed: () => speak(textstring),
                  //   child: Text("Start Text to Speech"),
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
}
