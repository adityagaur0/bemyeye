import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ProductInfoPage extends StatefulWidget {
  const ProductInfoPage({super.key});

  @override
  State<ProductInfoPage> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  final player = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.play(AssetSource("sounds/ProductScanner.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("Product Scanner")),
    );
  }
}
