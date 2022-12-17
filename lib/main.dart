import 'package:event_app/components/onboarding/onboarding_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mosaic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      home: const Scaffold(
        body: OnboardingScreenPage(),
      ),
    );
  }
}
