import 'package:flutter/material.dart';

class ProductScannerScreen extends StatefulWidget {
  const ProductScannerScreen({super.key});

  @override
  State<ProductScannerScreen> createState() => _ProductScannerScreenState();
}

class _ProductScannerScreenState extends State<ProductScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("product scanner"),
    );
  }
}
