import 'package:icansee/src/features/homepage.dart';
import 'package:icansee/src/startup/startup_view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFF4E9E9),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const StartupView(),
        '/home': (context) => const Home(),
      },
      theme: ThemeData().copyWith(
        // backgroundColor: Color(0xFFF4E9E9),
        //scaffoldBackgroundColor: Color(0xFFF4E9E9),
        brightness: Brightness.light,
        colorScheme: kColorScheme,
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        // bottomSheetTheme: BottomSheetThemeData().copyWith(
        //   backgroundColor: kColorScheme.background,
        // ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 26,
              ),
            ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer),
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
