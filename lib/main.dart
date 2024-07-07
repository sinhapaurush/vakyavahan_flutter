import 'package:flutter/material.dart';
import './screens/loader.dart';

void main() {
  runApp(const VakyaVahan());
}

class VakyaVahan extends StatelessWidget {
  const VakyaVahan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          // backgroundColor: Color.fromARGB(255, 48, 48, 48),
          backgroundColor: Color.fromARGB(255, 4, 68, 62),
          elevation: 2,
        ),
        colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.teal,
            onPrimary: Colors.white,
            secondary: Colors.grey,
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.black,
            background: Colors.black,
            onBackground: Colors.white,
            surface: Colors.black12,
            onSurface: Colors.white),
      ),
      home: const LoadingScreen(),
    );
  }
}
