// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakyavahan/methods/update_user.dart';
import 'package:vakyavahan/widget/simpletextbox.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController orgController = TextEditingController();

  TextEditingController authKeyController = TextEditingController();

  TextEditingController clientKeyController = TextEditingController();

  Future<void> fetchValuesFromSharedPrefs() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String name = sp.getString("username")!;
    String org = sp.getString("org")!;
    String authToken = sp.getString("auth")!;
    String clientToken = sp.getString("client")!;

    nameController.text = name;
    orgController.text = org;
    authKeyController.text = authToken;
    clientKeyController.text = clientToken;
  }

  @override
  void initState() {
    super.initState();
    fetchValuesFromSharedPrefs();
  }

  void updateUserMethod() async {
    bool updated =
        await updateUser(nameController.value.text, orgController.value.text);
    if (!updated && mounted) {
      showDialog(
          context: context,
          builder: (BuildContext context_) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: Text("Error"),
              content: Text(
                  "Vakyavahan encountered an internal error while updating your information."),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context_).pop(),
                    child: Text("Ok")),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: const Color.fromARGB(255, 58, 58, 58),
            title: const Text("Configurations"),
            centerTitle: true,
          ),
          Simpletextbox(label: "Name", controller: nameController),
          Simpletextbox(label: "Organisation Name", controller: orgController),
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: updateUserMethod,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.teal),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "API Keys",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Simpletextbox(
            label: "Auth Key",
            controller: authKeyController,
            readOnly: true,
          ),
          Simpletextbox(
              label: "Client Key",
              controller: clientKeyController,
              readOnly: true),
        ],
      ),
    );
  }
}
