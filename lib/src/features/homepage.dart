import 'package:icansee/src/constants/text_strings.dart';
import 'package:icansee/src/features/core/help_text/help_text.dart';
import 'package:icansee/src/features/core/recognition/combined_recognition.dart';
import 'package:icansee/src/features/core/screens/01read_text_screen/result_readtext_screen.dart';
//import 'package:icansee/src/features/core/help_text/currency_screen_help.dart';
import 'package:icansee/src/features/core/screens/02currency_screen/result_currency_screen.dart';
import 'package:flutter/material.dart';
import 'package:icansee/src/features/core/screens/03canvas/canvas_screen.dart';
import 'package:icansee/src/features/core/screens/04recognition/04product_scanner/product_scanner_initial_screen.dart';
import 'package:icansee/src/features/core/screens/04recognition/05object_recognition/object_recognition_result.dart';

import 'package:icansee/src/features/drawer.dart';
import 'package:icansee/src/service/tts_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // to track weather help overlay has been shown.
  bool helpOverlayShown = false;
  final TTSService ttsService = TTSService();

  List pages = [
    CombinedRecognitionScreen(
        resultPageBuilder: (text) => ResultReadTextScreen(textstring: text),
        recognitionType: RecognitionType.Text,
        ttext: tReadText),
    CombinedRecognitionScreen(
        resultPageBuilder: (text) => ResultCurrencyScreen(text: text),
        recognitionType: RecognitionType.Text,
        ttext: tcurrencyrecognition),
    CombinedRecognitionScreen(
        resultPageBuilder: (text) => ObjectResultScreen(text: text),
        recognitionType: RecognitionType.Object,
        ttext: tObjectRecognition),

    const CanvasScreen(),
    // const ProductScannerInital(),

    // const ProductScannerScreen(),
    // const ObjectRecognitionScreen(),
    // const ScenePage(),
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
      //speak the feature on changing the screen
      if (currentIndex == 0) {
        ttsService.speak(tReadText);
      } else if (currentIndex == 1) {
        ttsService.speak(tcurrencyrecognition);
      } else if (currentIndex == 3) {
        ttsService.speak(tcanvas);
      } else if (currentIndex == 4) {
        ttsService.speak(tProductScanner);
      } else if (currentIndex == 2) {
        ttsService.speak(tObjectRecognition);
      }
    });
  }

  void _openHelpOverlay() {
    //   6**************
    if (currentIndex == 0) {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: false,
        context: context,
        builder: (ctx) =>
            HelpText(ttstext: tReadText, ttexthelp: tReadTextHelp),
      );
    } else if (currentIndex == 1) {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: false,
        context: context,
        builder: (ctx) => HelpText(
            ttstext: tcurrencyrecognition, ttexthelp: tCurrencyScreenHelpTTS),
      );
    } else if (currentIndex == 3) {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: false,
        context: context,
        builder: (ctx) =>
            HelpText(ttstext: tcanvas, ttexthelp: tcanvasScreenHelpTTS),
      );
    } else if (currentIndex == 4) {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: false,
        context: context,
        builder: (ctx) =>
            HelpText(ttstext: tProductScanner, ttexthelp: tProductScannerHelp),
      );
    } else if (currentIndex == 2) {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: false,
        context: context,
        builder: (ctx) => HelpText(
            ttstext: tObjectRecognition, ttexthelp: tObjectRecognitionHelp),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 56,
        title: const Center(
          child: Text(
            "ICANSEE",
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openHelpOverlay, //7****
            icon: const Icon(Icons.help),
          ),
        ],
      ),
      drawer: const DrawerHomePage(),
      body: pages[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.text_fields_sharp), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.currency_rupee_rounded), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.screenshot_monitor), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.draw_outlined), label: ''),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.qr_code_scanner_outlined), label: ''),
          ],
        ),
      ),
    );
  }
}
