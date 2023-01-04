import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:event_app/helpers/custom_snack_bar.dart';
import 'package:event_app/models/user_model.dart';
import 'package:event_app/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  static CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  static saveUserDataToFireStore({
    required String fullName,
    required String email,
    required phoneNumber,
    required String imageLink,
  }) {
    users.add({
      "fullName": fullName,
      "email": email,
      "phone": phoneNumber,
      "imageLink": imageLink,
    }).then(
      (value) {
        Utils.showSuccessSnackBar("User Added Successfully.");
        UserController.getCurrentUserDetail();
      },
    ).catchError((error) =>
        Utils.showErrorSnackBar("There was an error when adding the user."));
  }

  static removeUser() {}

  static updateUser() {}

  static getCurrentUserDetail() async {
    // TODO DO some fixes
    String? email = FirebaseAuth.instance.currentUser?.email;
    String doc = "";

    await users.where('email', isEqualTo: email).get().then((snapshot) {
      snapshot.docs;
      String fullName = snapshot.docs.first.get("fullName");
      String email = snapshot.docs.first.get("email");
      String imageLink = snapshot.docs.first.get("imageLink");
      String phoneNumber = snapshot.docs.first.get("phone");
      String docId = snapshot.docs.first.id;

      currentUser = UserModel(
        fullName: fullName,
        email: email,
        imageLink: imageLink,
        phoneNumber: phoneNumber,
        docId: docId,
      );
    });
    print(doc);
  }
}
