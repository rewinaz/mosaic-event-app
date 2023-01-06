import 'package:event_app/firebase_options.dart';
import 'package:event_app/helpers/custom_snack_bar.dart';
import 'package:event_app/screens/auth.dart';
import 'package:event_app/screens/wrapper_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Mosaic',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WrapperScreen();
            // return CheckoutScreen(
            //   data: EventModel(
            //     eventName: "eventName",
            //     category: "category",
            //     venueName: "venueName",
            //     venueAddress: "venueAddress",
            //     description: "description",
            //     isActive: false,
            //     isFeatured: false,
            //     quantity: 500,
            //     price: 499,
            //     startDate: DateTime.now(),
            //     endDate: DateTime.now(),
            //     images: [],
            //     postedBy: "postedBy",
            //   ),
            // );
            // return EventDetailScreen();
          } else {
            return AuthScreen();
          }
        },
      ),
    );
  }
}
