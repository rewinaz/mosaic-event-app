import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_button.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:event_app/screens/home_screen.dart';
import 'package:event_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRememberMeChecked = false;
  final Color enabledBorderColor = const Color.fromRGBO(249, 249, 255, 1.0);
  final Color fillColor = const Color.fromRGBO(249, 249, 255, 1.0);
  @override
  void initState() {
    super.initState();
    isRememberMeChecked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Sign In",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  margin: const EdgeInsets.only(bottom: 30, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      // Email TextInput
                      CustomTextField(
                          inputController: _emailController,
                          hintText: "rewinazerou@gmail.com",
                          labelText: "Email",
                          prefixIcon: Icons.mail_outlined,
                          filledColor: fillColor,
                          borderRadius: 25,
                          enabledBorderColor: enabledBorderColor),

                      // Password TextInput
                      CustomTextField(
                        inputController: _passwordController,
                        labelText: "Password",
                        prefixIcon: Icons.lock_outlined,
                        obsecureText: true,
                        filledColor: fillColor,
                        borderRadius: 25,
                        enabledBorderColor: enabledBorderColor,
                      ),

                      // Forget Password and remember me section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: isRememberMeChecked,
                                  onChanged: (checked) => {
                                        setState((() {
                                          isRememberMeChecked =
                                              !isRememberMeChecked;
                                        }))
                                      }),
                              const Text(
                                "Remember me",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Forget Password ?",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                CustomButton(
                  buttonText: "Sign in",
                  buttonOnClick: () {
                    // TODO Handle Signin onClick
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  isFilled: true,
                ),

                const SizedBox(
                  height: 20,
                ),

                // Don't Have an account section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO Implement routing to signin
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => SignupScreen()));
                      },
                      child: const Text(
                        " Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(46, 136, 232, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
