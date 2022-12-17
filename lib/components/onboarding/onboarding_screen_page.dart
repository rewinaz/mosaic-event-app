import 'package:flutter/material.dart';

class OnboardingScreenPage extends StatelessWidget {
  const OnboardingScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("lib/assets/images/onboarding_1.png"),
          Column(
            children: [
              Text("Welcome to \nMosaic Event App"),
              Text(
                  "Find the best event near you with just one of the best app."),
              MaterialButton(
                onPressed: () {},
                child: Text("Get Started"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
