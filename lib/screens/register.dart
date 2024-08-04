import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakyavahan/methods/auto_login.dart';
import 'package:vakyavahan/methods/server.dart';
import 'package:vakyavahan/methods/verify_user.dart';
import 'package:vakyavahan/screens/home.dart';
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
  bool isProgress = true;

  void showProgress() {
    setState(() {
      isProgress = true;
    });
  }

  Future<void> checkExistingLoginCreds() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? authToken = sp.getString("auth");
    String? clientToken = sp.getString("client");

    if ((authToken != null) && (clientToken != null)) {
      bool validUser = await verifyExistingLoginCredentials();
      if (mounted == true && validUser == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context_) {
            return const HomeScreen();
          }),
        );
      } else {
        if (mounted) {
          showDialog(
              context: context,
              builder: (BuildContext context_) {
                return AlertDialog(
                  backgroundColor: Colors.black,
                  title: const Text("Oops!"),
                  content: const Text(
                      "Couldn't find your token on the server. This could be because the token were revoked due to inactivity."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "Ok",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                );
              });
        }
        setState(() {
          isProgress = false;
        });
      }
    } else {
      DeviceInfoPlugin device = DeviceInfoPlugin();
      var androidInfo = await device.androidInfo;
      String devID = androidInfo.id;
      bool autoSignInSuccess = await autoLogin(devID);
      if (!autoSignInSuccess) {
        setState(() {
          isProgress = false;
        });
      } else {
        if (mounted) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) {
            return const HomeScreen();
          }));
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkExistingLoginCreds();
  }

  void hideProgress() {
    setState(() {
      isProgress = false;
    });
    Navigator.of(context).pop();
  }

  Future<void> validate() async {
    String name = nameHandler.value.text;
    String org = orgHandler.value.text;
    bool hitApi = true;

    if (name.length < 2) {
      setState(() {
        nameErr = "Enter full name";
      });
      hitApi = false;
    }
    if (!(org.length > 3)) {
      setState(() {
        orgErr = "Enter complete organisation name";
      });
      hitApi = false;
    }

    if (hitApi) {
      showProgress();
      bool didCreatedNewUser = await newAccountRequest(name, org);
      if (!didCreatedNewUser) {
        if (mounted) {
          showDialog(
              context: context,
              builder: (BuildContext context_) {
                return AlertDialog(
                  backgroundColor: Colors.black,
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
      } else {
        if (mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context_) => const HomeScreen()));
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
