import 'package:flutter/material.dart';
import '../../widget/message.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 48, 48, 48)),
            child: TextField(
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext conttext_, int index) {
              return const SMSBox(
                message: "You OTP is 198738",
                phone: "987456321",
                time: "13 April 2024, 18:00",
              );
            },
            childCount: 10,
          ),
        ),
      ],
    );
  }
}
