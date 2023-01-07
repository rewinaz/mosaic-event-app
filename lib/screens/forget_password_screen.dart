import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_button.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:event_app/helpers/custom_snack_bar.dart';
import 'package:event_app/helpers/form_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final Color fillColor = const Color.fromRGBO(249, 249, 255, 1.0);
  final Color enabledBorderColor = const Color.fromRGBO(249, 249, 255, 1.0);

  forgetPassword() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
            email: _emailController.text.trim(),
          )
          .then((value) => Utils.showSuccessSnackBar(
              "Password reset link has been sent to your email."));
    } on FirebaseAuthException catch (e) {
      Utils.showErrorSnackBar("Something went wrong please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: "Password Reset",
          leadingIcon: Icons.arrow_back_ios,
          leadingOnTap: () {
            Navigator.pop(context);
          }),
      body: Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                inputController: _emailController,
                hintText: "Your Email",
                labelText: "Email",
                // prefixIcon: Icons.mail_outlined,
                filledColor: fillColor,
                borderRadius: 25,
                enabledBorderColor: enabledBorderColor,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => FormValidators.emailValidator(value),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                buttonText: "Reset Password",
                buttonOnClick: () => forgetPassword(),
                isFilled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
