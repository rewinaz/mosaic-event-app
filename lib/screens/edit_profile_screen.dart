import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_button.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:event_app/controllers/user_controller.dart';
import 'package:event_app/helpers/custom_snack_bar.dart';
import 'package:event_app/helpers/firebase_helpers.dart';
import 'package:event_app/helpers/form_validators.dart';
import 'package:event_app/helpers/get_image_from_gallery.dart';
import 'package:event_app/models/user_model.dart';
import 'package:event_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateUserScreen extends StatefulWidget {
  String? currentImageLink;
  UpdateUserScreen({super.key, this.currentImageLink});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final Color fillColor = const Color.fromRGBO(249, 249, 255, 1.0);
  final Color enabledBorderColor = const Color.fromRGBO(249, 249, 255, 1.0);
  final Color lightGray = const Color.fromRGBO(249, 249, 255, 1.0);
  final Color blueColor = const Color.fromRGBO(46, 137, 232, 1);
  XFile? profilePicture;
  bool imageRemoved = false;

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

  removeCurrentImage() {
    setState(() {
      imageRemoved = true;
    });
  }

  updateOonClickHandler(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    String imageUrl = currentUser.imageLink;
    if (imageRemoved == true && profilePicture == null) {
      Utils.showErrorSnackBar("Please Select profile picture.");
      return;
    }

    if (profilePicture != null) {
      await FirebaseHelperFunctions.removeImageFromFirestore(imageUrl);
      imageUrl = await FirebaseHelperFunctions.uploadFileToFireStore(
        File(profilePicture!.path),
        "profile_pictures",
        profilePicture!.name,
      );
    }

    await UserController.updateUser(
      phoneNumber: _phoneController.text.trim(),
      fullName: _fullNameController.text.trim(),
      imageLink: imageUrl,
      docId: currentUser.docId,
    );

    Navigator.pop(context);
  }

  @override
  void initState() {

    profilePicture = null;
    if (currentUser.imageLink.isEmpty) {
      imageRemoved = true;
    } else {
      imageRemoved = false;
    }

    _fullNameController.text = currentUser.fullName;
    _phoneController.text = currentUser.phoneNumber;
    _fullNameController = _fullNameController;
    _phoneController = _phoneController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Update Profile",
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
                        imageRemoved == true
                            ? imageIsFile(
                                profilePicture: profilePicture,
                                removeProfilePicture: removeProfilePicture,
                                getProfilePicture: getProfilePicture,
                                backgroundColor: lightGray,
                                iconColor: blueColor,
                              )
                            : imageIsLink(
                                imageLink: currentUser.imageLink,
                                removeProfilePicture: () =>
                                    removeCurrentImage(),
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
                        // Forget Password and remember me section
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  buttonText: "Update",
                  buttonOnClick: () {
                    updateOonClickHandler(context);
                  },
                  isFilled: true,
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

Widget imageIsFile({
  XFile? profilePicture,
  required Function removeProfilePicture,
  required Function getProfilePicture,
  required Color backgroundColor,
  required Color iconColor,
}) {
  return GestureDetector(
    onTap: () =>
        {profilePicture != null ? removeProfilePicture() : getProfilePicture()},
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: CircleAvatar(
        radius: 50,
        backgroundColor: backgroundColor,
        child: profilePicture == null
            ? Icon(
                Icons.camera_alt_outlined,
                size: 70,
                color: iconColor,
              )
            : ClipOval(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(
                      File(profilePicture.path),
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
  );
}

Widget imageIsLink({
  required String imageLink,
  required Function removeProfilePicture,
}) {
  return GestureDetector(
    onTap: () => {removeProfilePicture()},
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: CircleAvatar(
        radius: 50,
        child: ClipOval(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: currentUser.imageLink,
                fit: BoxFit.cover,
                width: double.infinity,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
                errorWidget: (context, url, error) => errorImage(),
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
  );
}

Widget errorImage() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      width: 90,
      height: 90,
      color: Colors.grey.shade300,
      child: Icon(
        Icons.person,
        color: Colors.black,
        size: 80,
      ),
    ),
  );
}
