import 'package:flutter/material.dart';

class DrawerHomePage extends StatelessWidget {
  const DrawerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          ListTile(
            title: Text(
              "About",
            ),
            leading: Icon(Icons.info_outline_rounded),
          ),
          ListTile(
            title: Text(
              "Help",
            ),
            leading: Icon(Icons.help_outline_outlined),
          ),
          ListTile(
            title: Text(
              "About",
            ),
            leading: Icon(Icons.settings_outlined),
          ),
          ListTile(
            title: Text(
              "Feedback",
            ),
            leading: Icon(Icons.feedback_outlined),
          ),
        ],
      ),
    );
  }
}
