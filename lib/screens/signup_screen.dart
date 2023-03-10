import 'dart:io';
import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_button.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:event_app/controllers/user_controller.dart';
import 'package:event_app/helpers/firebase_helpers.dart';
import 'package:event_app/helpers/form_validators.dart';
import 'package:event_app/helpers/get_image_from_gallery.dart';
import 'package:event_app/helpers/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  VoidCallback onClickedSignIn;
  SignupScreen({super.key, required this.onClickedSignIn});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
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
  XFile? profilePicture;

  getProfilePicture() async {
    XFile? image = await getImageFromGallery();
    setState(() {
      profilePicture = image;
    });
  }

  removeProfilePicture() {
    setState(() {
      profilePicture = null;
    });
  }

  signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (profilePicture == null) {
      Utils.showErrorSnackBar("Please select profile image.");
      return;
    }

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then(
        (value) async {
          String imageUrl = "";
          if (profilePicture != null) {
            imageUrl = await FirebaseHelperFunctions.uploadFileToFireStore(
              File(profilePicture!.path),
              "profile_pictures",
              profilePicture!.name,
            );
          }

          UserController.saveUserDataToFireStore(
            fullName: _fullNameController.text.trim(),
            email: _emailController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            imageLink: imageUrl,
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      Utils.showErrorSnackBar(e.message);
    }
  }

  @override
  void initState() {
    profilePicture = null;
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Sign Up",
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => {
                            profilePicture != null
                                ? removeProfilePicture()
                                : getProfilePicture()
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: lightGray,
                              child: profilePicture == null
                                  ? Icon(
                                      Icons.camera_alt_outlined,
                                      size: 70,
                                      color: blueColor,
                                    )
                                  : ClipOval(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.file(
                                            File(profilePicture!.path),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                          Icon(
                                            Icons.close_rounded,
                                            size: 70,
                                            color: Colors.red.shade600,
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        // Email TextInput
                        CustomTextField(
                          inputController: _fullNameController,
                          labelText: "Full Name",
                          filledColor: fillColor,
                          borderRadius: 25,
                          enabledBorderColor: enabledBorderColor,
                          textInputType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              FormValidators.fullNameValidator(value),
                        ),

                        // Password TextInput
                        CustomTextField(
                          inputController: _phoneController,
                          labelText: "Phone",
                          filledColor: fillColor,
                          borderRadius: 25,
                          enabledBorderColor: enabledBorderColor,
                          textInputType: TextInputType.phone,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              FormValidators.phoneValidator(value),
                        ),
                        CustomTextField(
                          inputController: _emailController,
                          labelText: "Email",
                          filledColor: fillColor,
                          borderRadius: 25,
                          enabledBorderColor: enabledBorderColor,
                          textInputType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              FormValidators.emailValidator(value),
                        ),
                        CustomTextField(
                          inputController: _passwordController,
                          labelText: "Password",
                          obsecureText: true,
                          filledColor: fillColor,
                          borderRadius: 25,
                          enabledBorderColor: enabledBorderColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              FormValidators.passwordConfirmValidator(
                            value,
                            _confirmPasswordController.text.trim(),
                          ),
                        ),
                        CustomTextField(
                          inputController: _confirmPasswordController,
                          labelText: "Confirm Password",
                          obsecureText: true,
                          filledColor: fillColor,
                          borderRadius: 25,
                          enabledBorderColor: enabledBorderColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              FormValidators.passwordConfirmValidator(
                            value,
                            _passwordController.text.trim(),
                          ),
                        ),

                        // Forget Password and remember me section
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  buttonText: "Sign up",
                  buttonOnClick: () {
                    signUp();
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
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onClickedSignIn,
                      child: const Text(
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

                const SizedBox(
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
