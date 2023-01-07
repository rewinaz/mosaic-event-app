import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_button_rounded.dart';
import 'package:event_app/models/user_model.dart';
import 'package:event_app/screens/edit_profile_screen.dart';
import 'package:event_app/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel user = currentUser;

  @override
  void initState() {
    super.initState();
    user = currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: "Profile"),
      extendBody: true,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: currentUser.imageLink,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                        errorWidget: (context, url, error) => errorImage(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    currentUser.fullName,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                // CustomButtonRounded(
                //   buttonText: "Dashboard",
                //   buttonOnClick: () {},
                // ),
                // SizedBox(
                //   width: 20,
                // ),
                CustomButtonRounded(
                  backgroundColor: Colors.blue,
                  buttonText: "Edit Profile",
                  buttonOnClick: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateUserScreen(
                                currentImageLink: currentUser.imageLink,
                              ))),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomButtonRounded(
              buttonText: "LogOut",
              buttonOnClick: () {
                FirebaseAuth.instance.signOut();
              },
              backgroundColor: Colors.redAccent,
            )
          ],
        ),
      )),
    );
  }
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
