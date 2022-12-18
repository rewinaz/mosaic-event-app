import 'package:flutter/material.dart';

class OnboardingScreenPage extends StatelessWidget {
  const OnboardingScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: screenHeight * 0.5,
              child: Image.asset("lib/assets/images/onboarding_1.png")),
          Container(
            width: double.maxFinite,
            height: screenHeight * 0.5,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                border: Border.fromBorderSide(BorderSide(color: Colors.red))),
            child: Column(
              children: [
                Text(
                  "Welcome to \nMosaic Event App",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Find the best event near you with just one of the best app.",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text("Get Started"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
