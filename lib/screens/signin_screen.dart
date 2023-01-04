import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_button.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:event_app/controllers/user_controller.dart';
import 'package:event_app/helpers/form_validators.dart';
import 'package:event_app/helpers/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  VoidCallback onClickedSignUp;
  SignInScreen({super.key, required this.onClickedSignUp});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRememberMeChecked = false;
  final Color enabledBorderColor = const Color.fromRGBO(249, 249, 255, 1.0);
  final Color fillColor = const Color.fromRGBO(249, 249, 255, 1.0);

  signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()).then((value) => UserController.getCurrentUserDetail());
    } on FirebaseAuthException catch (e) {
      Utils.showErrorSnackBar(e.message);
    }

    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void initState() {
    super.initState();
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
            child: Wrap(
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // Email TextInput
                        CustomTextField(
                          inputController: _emailController,
                          hintText: "Your Email",
                          labelText: "Email",
                          // prefixIcon: Icons.mail_outlined,
                          filledColor: fillColor,
                          borderRadius: 25,
                          enabledBorderColor: enabledBorderColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              FormValidators.emailValidator(value),
                        ),

                        // Password TextInput
                        CustomTextField(
                          inputController: _passwordController,
                          labelText: "Password",
                          // prefixIcon: Icons.lock_outlined,
                          obsecureText: true,
                          filledColor: fillColor,
                          borderRadius: 25,
                          enabledBorderColor: enabledBorderColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              FormValidators.passwordValidator(value),
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
                ),
                CustomButton(
                  buttonText: "Sign in",
                  buttonOnClick: () => signIn(),
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
                      onTap: widget.onClickedSignUp,
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
