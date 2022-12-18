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
      backgroundColor: Colors.grey,
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
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: MaterialButton(
                    onPressed: () {
                      buttonOnClick();
                    },
                    color: Colors.blue,
                    minWidth: double.infinity,
                    elevation: 0,
                    height: 60,
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
