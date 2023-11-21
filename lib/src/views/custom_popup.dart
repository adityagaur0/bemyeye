import 'package:flutter/material.dart';

class CustomPopupMessage extends StatelessWidget {
  final String title;
  final String message;

  const CustomPopupMessage({super.key, 
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the pop-up
          },
        ),
      ],
    );
  }
}
