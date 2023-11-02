import 'package:bemyeye/ui/views/helppage/text_read_help.dart';
import 'package:bemyeye/ui/views/navpages/book_reader.dart';
import 'package:bemyeye/ui/views/navpages/currency_page.dart';
import 'package:bemyeye/ui/views/navpages/document_page.dart';
import 'package:bemyeye/ui/views/navpages/person_page.dart';
import 'package:bemyeye/ui/views/navpages/product_page.dart';
import 'package:bemyeye/ui/views/navpages/readtext_page.dart';
import 'package:bemyeye/ui/views/navpages/scene_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List pages = [
    const ReadTextPage(),
    const DocumentPage(),
    const BookReader(),
    const ProductInfoPage(),
    const PersonInfoPage(),
    const CurrencyPage(),
    const ScenePage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
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
        title: const Center(child: Text("Be My Eye")),
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
                icon: Icon(Icons.document_scanner_rounded), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.book_rounded), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner_sharp), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.man), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.currency_rupee_rounded), label: ''),
          ],
        ),
      ),
    );
  }
}
