import 'package:flutter/material.dart';
import 'package:vakyavahan/screens/main/config.dart';
import 'package:vakyavahan/screens/main/messages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const List<Widget> bottomNavigationBarScreens = [
  MessagesScreen(),
  ConfigScreen()
];

class _HomeScreenState extends State<HomeScreen> {
  int currentScreenIndex = 0; //DEFAULT SCREEN FOR BOTTOM NAVIGATION BAR

  void jumpToScreen(int index) {
    setState(() {
      currentScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreenIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: "Donate",
            tooltip: "Please cutie, donate up. You'll get my prayers, god will help you"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "Config"),
        ],
        onTap: (int index) => jumpToScreen(index),
      ),
      body: bottomNavigationBarScreens[currentScreenIndex],
    );
  }
}
