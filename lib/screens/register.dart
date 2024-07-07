import 'package:flutter/material.dart';
import 'package:vakyavahan/methods/server.dart';
import 'package:vakyavahan/widget/button.dart';
import 'package:vakyavahan/widget/textbox.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State createState() => RegisterState();
}

class RegisterState extends State {
  final TextEditingController nameHandler = TextEditingController();
  final TextEditingController mailHandler = TextEditingController();
  final TextEditingController orgHandler = TextEditingController();
  final TextEditingController npassHandler = TextEditingController();
  final TextEditingController cpassHandler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "VakyaVahan",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                "Create an Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          TextBox(
            label: "Name",
            hint: "Full Name",
            controller: nameHandler,
          ),
          TextBox(
              label: "E-Mail",
              hint: "abc@example.com",
              controller: mailHandler),
          TextBox(
              label: "Organisation",
              hint: "Company Name",
              controller: orgHandler),
          TextBox(
              label: "Create Password",
              hint: "********",
              controller: npassHandler,
              secureText: true),
          TextBox(
            label: "Confirm Password",
            hint: "********",
            controller: cpassHandler,
            secureText: true,
          ),
          PrimaryBtn(
            onPress: () => Server.newUser(
              name: nameHandler.value.text,
              organisation: orgHandler.value.text,
              mail: mailHandler.value.text,
              password: npassHandler.value.text,
            ),
            text: "Click Me",
          ),
        ],
      ),
    );
  }
}
