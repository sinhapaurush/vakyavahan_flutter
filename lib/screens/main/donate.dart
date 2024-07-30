import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateScreen extends StatelessWidget {
  DonateScreen({super.key});

  Function launchDonation = () async {
    Uri donationPage = Uri.parse("https://buymeacoffee.com/sinhapaurush");
    await launchUrl(donationPage);
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: const Color.fromARGB(255, 48, 48, 48),
          title: const Text("Buy Me a Fanta!"),
          centerTitle: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Text(
                """VakyaVahan is an open-source project designed to offer an API for sending SMS through user SIM cards. As an independent developer, I am dedicated to maintaining and improving this project, but I need your support to continue this work. If you find VakyaVahan valuable and want to help sustain its development, please consider making a donation. Your contribution will go directly towards operational costs, feature enhancements, and ongoing maintenance. Every donation, no matter the amount, helps ensure that VakyaVahan remains a useful tool for everyone. Thank you for your support!""",
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => launchDonation(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 65, 65, 65),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    children: [
                      Icon(Icons.monetization_on),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Donate"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
