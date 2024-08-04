import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/message.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController searchBoxController = TextEditingController();
  List<Map> messageListToRender = [];

  Future<void> updateMsgList(String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String messagesMap = sp.getString("message")!;
    List<dynamic> tempArray = jsonDecode(messagesMap);
    List<Map> resultantArray = [];
    for (int i = 0; i < tempArray.length; i++) {
      Map currentElement = tempArray[i];
      if (currentElement['phone']!.replaceAll(" ", "").contains(value)) {
        resultantArray.add(currentElement);
        continue;
      }
      if (currentElement['message']
          .toString()
          .replaceAll(" ", "")
          .toLowerCase()
          .contains(value.replaceAll(" ", "").toLowerCase())) {
        resultantArray.add(currentElement);
        continue;
      }
    }
    setState(() {
      messageListToRender = resultantArray;
    });
  }

  Future<void> loadList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String messageInStorage = sp.getString("message")!;
    List<Map<String, dynamic>> loadedInMap =
        List<Map<String, dynamic>>.from(jsonDecode(messageInStorage));
    setState(() {
      messageListToRender = loadedInMap;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 54, 54, 54),
      statusBarBrightness: Brightness.light,
    ));
    loadList();
  }

  @override
  Widget build(BuildContext context) {
    searchBoxController.addListener(() {
      String currentValue = searchBoxController.value.text;
      updateMsgList(currentValue);
    });
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 48, 48, 48)),
              child: TextField(
                controller: searchBoxController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search Messages",
                    hintStyle: const TextStyle(),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 75, 75, 75),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintFadeDuration: const Duration(milliseconds: 100)),
              ),
            ),
          ),
          messageListToRender.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Column(
                        children: [
                          Icon(Icons.emoji_emotions, size: 60,),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Nothing to show here", style: TextStyle(
                            fontSize: 20
                          ),)
                        ],
                      ),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext conttext_, int index) {
                      return SMSBox(
                        message: messageListToRender[index]['message'],
                        phone: messageListToRender[index]['phone'],
                        time: messageListToRender[index]['time'],
                      );
                    },
                    childCount: messageListToRender.length,
                  ),
                ),
        ],
      ),
    );
  }
}
