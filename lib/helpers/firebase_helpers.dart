import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelperFunctions {
  static Future<String> uploadFileToFireStore(
    File file,
    String folderName,
    String fileName,
  ) async {
    String path = "$folderName/$fileName";
    final ref = FirebaseStorage.instance.ref().child(path);

    UploadTask uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});

    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static removeImageFromFirestore(String imageLink) async {
    final ref = FirebaseStorage.instance.refFromURL(imageLink);
// Delete the file
    await ref.delete();
  }
}
