import 'package:event_app/components/custom_button.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final Color fillColor = const Color.fromRGBO(249, 249, 255, 1.0);
  final Color enabledBorderColor = const Color.fromRGBO(249, 249, 255, 1.0);
  final Color lightGray = const Color.fromRGBO(249, 249, 255, 1.0);
  final Color blueColor = const Color.fromRGBO(46, 137, 232, 1);
  bool isTermsAgreed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // ignore: prefer_const_constructors
        title: Text(
          "Sign up",
          style: const TextStyle(
            fontSize: 22,
            color: Color.fromRGBO(54, 61, 78, 1),
          ),
        ),
        centerTitle: true,
        leading: Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 40,
            color: Colors.black,
          ),
        ),
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: CircleAvatar(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 70,
                            color: blueColor,
                          ),
                          radius: 50,
                          backgroundColor: lightGray,
                        ),
                      ),
                      // Email TextInput
                      CustomTextField(
                        inputController: _emailController,
                        labelText: "Full Name",
                        filledColor: fillColor,
                        borderRadius: 25,
                        enabledBorderColor: enabledBorderColor,
                        textInputType: TextInputType.name,
                      ),

                      // Password TextInput
                      CustomTextField(
                        inputController: _passwordController,
                        labelText: "Phone",
                        filledColor: fillColor,
                        borderRadius: 25,
                        enabledBorderColor: enabledBorderColor,
                        textInputType: TextInputType.phone,
                      ),
                      CustomTextField(
                          inputController: _passwordController,
                          labelText: "Email",
                          filledColor: fillColor,
                          borderRadius: 25,
                          enabledBorderColor: enabledBorderColor,
                          textInputType: TextInputType.emailAddress),
                      CustomTextField(
                        inputController: _passwordController,
                        labelText: "Password",
                        obsecureText: true,
                        filledColor: fillColor,
                        borderRadius: 25,
                        enabledBorderColor: enabledBorderColor,
                      ),
                      CustomTextField(
                        inputController: _passwordController,
                        labelText: "Confirm Password",
                        obsecureText: true,
                        filledColor: fillColor,
                        borderRadius: 25,
                        enabledBorderColor: enabledBorderColor,
                      ),

                      // Forget Password and remember me section

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isTermsAgreed,
                            onChanged: (checked) =>
                                {isTermsAgreed = !isTermsAgreed},
                          ),
                          const Text(
                            "By creating an account you agree \nto our Terms of Service and \nPrivacy Policy",
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                CustomButton(
                  buttonText: "Sign up",
                  buttonOnClick: () {},
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
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO Implement routing to signin
                      },
                      child: Text(
                        " Sign In",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(46, 136, 232, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
