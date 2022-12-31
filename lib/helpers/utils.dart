import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showErrorSnackBar(String? message) {
    if (message == null) return;
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showSuccessSnackBar(String? message) {
    if (message == null) return;
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
