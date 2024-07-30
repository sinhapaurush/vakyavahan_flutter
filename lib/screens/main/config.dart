// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: const Color.fromARGB(255, 58, 58, 58),
          title: const Text("Configurations"),
          centerTitle: true,
        ),
        Simpletextbox(label: "Name", controller: nameController),
        Simpletextbox(label: "Organisation Name", controller: orgController),
        Simpletextbox(
          label: "Auth Key",
          controller: authKeyController,
          readOnly: true,
        ),
        Simpletextbox(
          label: "Client Key",
          controller: clientKeyController,
          readOnly: true,
        ),
      ],
    );
  }
}
