import 'package:event_app/components/onboarding/onboarding_screen_page.dart';
import 'package:event_app/screens/onboarding_screen.dart';
import 'package:event_app/screens/signin_screen.dart';
import 'package:event_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

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
      home: const Scaffold(body: SignupScreen()),
    );
  }
}
