import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakyavahan/screens/main/donate.dart';
import 'package:vakyavahan/screens/main/config.dart';
import 'package:vakyavahan/screens/main/messages.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Widget> bottomNavigationBarScreens = [
  const MessagesScreen(),
  const DonateScreen(),
  const ConfigScreen()
];

class _HomeScreenState extends State<HomeScreen> {
  int currentScreenIndex = 0; //DEFAULT SCREEN FOR BOTTOM NAVIGATION BAR

  void jumpToScreen(int index) {
    setState(() {
      currentScreenIndex = index;
    });
  }

  Future<void> connectToSocket() async {
    print('here');
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? auth = sp.getString("auth");
    String? client = sp.getString("client");

    final Map credentialsMap = {"auth": auth, "client": client};
    String jsonToSend = jsonEncode(credentialsMap);
    String serverPath = "ws://192.168.148.201:5000";
    IO.Socket socket = IO.io(serverPath);
    socket.onError((_) {
      print("Error idhar hai billo $serverPath $_");
    });
    socket.onConnect((io) {
      print('connected to server');
      socket.emit("credentials", jsonToSend);
    });
    socket.on("sendsms", (msg) async {
      Map data = jsonDecode(msg);
      String message = data['message'];
      String to = data['to'];

      String idk =
          await sendSMS(message: message, recipients: [to], sendDirect: true);
      print(idk);
    });
    socket.onDisconnect((_) {
      showDialog(
          context: context,
          builder: (BuildContext context_) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: const Text("Something Went Wrong"),
              content: const Text("Server kicked us out!"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context_).pop(),
                  child: const Text("Ok"),
                )
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    connectToSocket();
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
              tooltip:
                  "Please cutie, donate up. You'll get my prayers, god will help you"),
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
