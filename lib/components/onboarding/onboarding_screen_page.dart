import 'package:event_app/components/custom_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreenPage extends StatelessWidget {
  String pageTitle = "";
  String pageImage = "";
  String pageDescription = "";
  String buttonText = "";
  Function buttonOnClick;

  OnboardingScreenPage({
    super.key,
    required this.pageTitle,
    required this.pageDescription,
    required this.buttonText,
    required this.pageImage,
    required this.buttonOnClick,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 255, 1),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 60),
              height: screenHeight * 0.55,
              child: Image.asset(pageImage)),
          Container(
            width: double.maxFinite,
            height: screenHeight * 0.45,
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    pageTitle,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    pageDescription,
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                  ),
                ),
                CustomButton(
                  buttonText: buttonText,
                  buttonOnClick: buttonOnClick,
                  isFilled: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
