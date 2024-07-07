import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool? secureText;
  const TextBox({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.secureText,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: SizedBox(
        width: 0.85 * MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 8),
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 97, 97, 97),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                alignment: AlignmentDirectional.center,
                height: 30,
                child: TextField(
                  obscureText: secureText ?? false,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
