import 'package:flutter/material.dart';

class SMSBox extends StatelessWidget {
  final String message;
  final String time;
  final String phone;

  const SMSBox({
    super.key,
    required this.message,
    required this.time,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 71, 71, 71),
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  size: 15,
                  color: Color.fromARGB(255, 209, 209, 209),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  phone,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 209, 209, 209)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.calendar_month,
                  size: 15,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(time)
              ],
            )
          ],
        ),
      ),
    );
  }
}
