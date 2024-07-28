import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  final void Function() onPress;
  final String text;
  final double? marginTop;
  const PrimaryBtn(
      {super.key, required this.onPress, required this.text, this.marginTop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: marginTop ?? 20),
      child: InkWell(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 7, 105, 95),
            borderRadius: BorderRadius.circular(7),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Text(text),
        ),
      ),
    );
  }
}
