import 'package:bemyeye/src/features/core/screens/01read_text_screen/read_text_help.dart';
import 'package:bemyeye/src/features/core/screens/02currency_screen/currency_screen.dart';
import 'package:bemyeye/src/features/core/screens/01read_text_screen/readtext_screen.dart';
import 'package:bemyeye/src/features/core/screens/03canvas/canvas_screen.dart';
import 'package:bemyeye/src/features/core/screens/04product_scanner/product_scanner_screen.dart';
import 'package:bemyeye/src/features/core/screens/05object_recognition/object_recognition_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // to track weather help overlay has been shown.
  bool helpOverlayShown = false;

  List pages = [
    const ReadTextPage(),
    const CurrencyPage(),
    const CanvasScreen(),
    const ProductScannerScreen(),
    const ObjectRecognitionScreen(),
    // const ScenePage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      // Check if the user is moving to index 0 and the help overlay hasn't been shown yet
      if (index == 0 && !helpOverlayShown) {
        //_openHelpOverlay();
        helpOverlayShown = true; // Set the flag to true
      }
      currentIndex = index;
    });
  }

  void _openHelpOverlay() {
    //   6**************
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const TextReadHelp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("ICANSEE")),
        actions: [
          IconButton(
            onPressed: _openHelpOverlay, //7****
            icon: const Icon(Icons.help),
          ),
        ],
      ),
      drawer: const Drawer(),
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
            BottomNavigationBarItem(icon: Icon(Icons.draw_outlined), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.screenshot_monitor), label: ''),
          ],
        ),
      ),
    );
  }
}
