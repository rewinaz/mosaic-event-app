import 'package:event_app/screens/signin_screen.dart';
import 'package:event_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggle() => {
    setState(()=> {
      isLogin = !isLogin
    })
  };
  @override
  Widget build(BuildContext context) {
    return isLogin ? SignInScreen(onClickedSignUp: toggle) : SignupScreen(onClickedSignIn: toggle);
  }
}
