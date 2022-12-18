import 'package:event_app/components/onboarding/onboarding_screen_page.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          OnboardingScreenPage(
            pageTitle: "Welcome to\nMosaic Event App",
            pageDescription:
                "Find the best event near you with just one click of the best app.",
            buttonText: "GetStarted",
            pageImage: "lib/assets/images/onboarding_1.png",
            buttonOnClick: () {},
          ),
          OnboardingScreenPage(
            pageTitle: "Find And\nBook An Event",
            pageDescription:
                "Find the best event near you with just one click of the best app.",
            buttonText: "GetStarted",
            pageImage: "lib/assets/images/onboarding_2.png",
            buttonOnClick: () {},
          ),
          OnboardingScreenPage(
            pageTitle: "Organize\nA Premium Event",
            pageDescription:
                "Find the best event near you with just one click of the best app.",
            buttonText: "GetStarted",
            pageImage: "lib/assets/images/onboarding_3.png",
            buttonOnClick: () {},
          ),
        ],
      ),
    );
  }
}
