import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_button_rounded.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            SizedBox(
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
                      child: Image.asset(
                        "lib/assets/images/event_image.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "Palmy Lounge",
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
                  buttonText: "Edit Profile",
                  buttonOnClick: () {},
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
