import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Simpletextbox extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool? readOnly;

  const Simpletextbox({
    super.key,
    required this.label,
    required this.controller,
    this.readOnly,
  });

  @override
  State<Simpletextbox> createState() => _SimpletextboxState();
}

class _SimpletextboxState extends State<Simpletextbox> {
  bool copied = false;
  void copyString(String stringToCopy) async {
    await Clipboard.setData(ClipboardData(text: stringToCopy));
    setState(() {
      copied = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        readOnly: widget.readOnly ?? false,
        controller: widget.controller,
        // enabled: !(widget.readOnly ?? false),
        decoration: InputDecoration(
          suffixIcon: widget.readOnly == true
              ? InkWell(
                  onTap: () => copyString(widget.controller.value.text),
                  child: Icon(
                    copied == true ? Icons.done : Icons.copy,
                    size: 15,
                  ),
                )
              : null,
          suffixIconColor: Colors.white,
          filled: true,
          fillColor: const Color.fromARGB(255, 61, 61, 61),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          labelStyle: const TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          label: Text(widget.label),
        ),
      ),
    );
  }
}
