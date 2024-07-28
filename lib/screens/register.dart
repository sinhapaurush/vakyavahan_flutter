import 'package:flutter/material.dart';
import 'package:vakyavahan/methods/server.dart';
import 'package:vakyavahan/widget/button.dart';
import 'package:vakyavahan/widget/spacer.dart';
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

  String? nameErr;
  String? orgErr;
  bool isProgress = false;

  void showProgress() {
    setState(() {
      isProgress = true;
    });
  }

  void hideProgress() {
    setState(() {
      isProgress = false;
    });
  }

  Future<void> validate() async {
    String name = nameHandler.value.text;
    String org = orgHandler.value.text;
    double navigateToNextStep = 5;

    if (name.length < 2) {
      setState(() {
        nameErr = "Enter full name";
      });
      navigateToNextStep--;
    }
    if (!(org.length > 3)) {
      setState(() {
        orgErr = "Enter complete organisation name";
      });
      navigateToNextStep--;
    }

    if (navigateToNextStep == 5) {
      showProgress();
      bool didCreatedNewUser = await newAccountRequest(name, org);
      if (!didCreatedNewUser) {
        if (mounted) {
          showDialog(
              context: context,
              builder: (BuildContext context_) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Unable to complete the request"),
                  actions: [
                    TextButton(
                      child: const Text("Ok"),
                      onPressed: () => hideProgress(),
                    ),
                  ],
                );
              });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !isProgress
          ? AppBar(
              title: const Text(
                "VakyaVahan",
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
      body: !isProgress
          ? SingleChildScrollView(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            "Configure your client",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      TextBox(
                        label: "Name",
                        controller: nameHandler,
                        error: nameErr,
                      ),
                      TextBox(
                        label: "Organisation",
                        controller: orgHandler,
                        error: orgErr,
                      ),
                      PrimaryBtn(
                        onPress: () => validate(),
                        text: "Save",
                      ),
                      const Spacing(height: 20),
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Align(
                alignment: AlignmentDirectional.center,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
    );
  }
}
