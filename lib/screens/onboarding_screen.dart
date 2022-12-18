import 'package:event_app/components/onboarding/onboarding_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();

  void changeToNextPage(PageController controller) {
    controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              OnboardingScreenPage(
                pageTitle: "Welcome to\nMosaic Event App",
                pageDescription:
                    "Find the best event near you with just one click of the best app.",
                buttonText: "Next",
                pageImage: "lib/assets/images/onboarding_1.png",
                buttonOnClick: () {
                  changeToNextPage(_pageController);
                },
              ),
              OnboardingScreenPage(
                pageTitle: "Find And\nBook An Event",
                pageDescription:
                    "Find the best event near you with just one click of the best app.",
                buttonText: "Next",
                pageImage: "lib/assets/images/onboarding_2.png",
                buttonOnClick: () {
                  changeToNextPage(_pageController);
                },
              ),
              OnboardingScreenPage(
                pageTitle: "Organize\nA Premium Event",
                pageDescription:
                    "Find the best event near you with just one click of the best app.",
                buttonText: "Get Started",
                pageImage: "lib/assets/images/onboarding_3.png",
                buttonOnClick: () {
                  changeToNextPage(_pageController);
                },
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: const SlideEffect(
                spacing: 8.0,
                radius: 8.0,
                dotWidth: 20.0,
                dotHeight: 12.0,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 1.5,
                dotColor: Colors.blueAccent,
                activeDotColor: Colors.blueAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
