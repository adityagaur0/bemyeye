import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GlassContainer extends StatelessWidget {
  final String label;

  const GlassContainer(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double tHeight = MediaQuery.of(context).size.height;
    return Container(
      height: tHeight, // Fill the available height
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            // blurRadius: 16,
            // spreadRadius: 8,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (label == 'Product Scanner')
                  ? Lottie.asset('assets/lottie/lqrScanner.json')
                  : Lottie.asset('assets/lottie/lObjectRecognition.json'),

              // Text(
              //   label,
              //   style: const TextStyle(
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
