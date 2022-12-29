import 'package:event_app/components/custom_bottom_navigation_bar.dart';
import 'package:event_app/screens/add_new_event_screen.dart';
import 'package:event_app/screens/home_screen.dart';
import 'package:event_app/screens/onboarding_screen.dart';
import 'package:event_app/screens/signin_screen.dart';
import 'package:event_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: AddNewEventScreen(),
    );
  }
}
