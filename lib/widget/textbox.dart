import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextBox extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  String? error;
  bool? secureText;

  TextBox({
    super.key,
    required this.label,
    required this.controller,
    this.error,
    this.secureText,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: TextField(
        obscureText: secureText ?? false,
        controller: controller,
        decoration: InputDecoration(
          errorText: error,
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(5)),
          filled: true,
          fillColor: const Color.fromARGB(255, 63, 63, 63),
        ),
      ),
    );
  }
}
