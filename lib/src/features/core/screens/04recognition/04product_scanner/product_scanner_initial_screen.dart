import 'package:flutter/material.dart';
import 'package:icansee/src/comman_widgets/glass_container.dart';
import 'package:icansee/src/constants/text_strings.dart';
import 'package:icansee/src/features/core/screens/04recognition/04product_scanner/product_scanner_screen.dart';

class ProductScannerInital extends StatelessWidget {
  const ProductScannerInital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InkWell(
          onDoubleTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ObjectDetectorView(),
              ),
            );
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GlassContainer(tProductScanner),
          ),
        ),
      ),
    );
  }
}
