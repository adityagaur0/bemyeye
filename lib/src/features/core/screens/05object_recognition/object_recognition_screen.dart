import 'package:flutter/material.dart';

class ObjectRecognitionScreen extends StatefulWidget {
  const ObjectRecognitionScreen({super.key});

  @override
  State<ObjectRecognitionScreen> createState() =>
      _ObjectRecognitionScreenState();
}

class _ObjectRecognitionScreenState extends State<ObjectRecognitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("obejct recognition"),
    );
  }
}
