import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home.dart';
import './register.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  Future<void> getData(BuildContext bcontext) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? authKey = sp.getString("authkey");
    if (authKey != null) {
      Navigator.of(bcontext).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      Navigator.of(bcontext).pushReplacement(MaterialPageRoute(
        builder: (context) => Register(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        width: double.maxFinite,
        height: double.maxFinite,
        child: const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: Colors.teal,
            ),
          ),
        ),
      ),
    );
  }
}
