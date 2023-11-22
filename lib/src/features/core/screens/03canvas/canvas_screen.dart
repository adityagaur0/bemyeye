import 'package:flutter/material.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("canvas drawing"),
    );
  }
}
