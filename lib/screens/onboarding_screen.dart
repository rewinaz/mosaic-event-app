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
          OnboardingScreenPage(),
          OnboardingScreenPage(),
          OnboardingScreenPage(),
        ],
      ),
    );
  }
}