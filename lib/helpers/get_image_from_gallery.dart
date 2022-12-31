import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

getImageFromGallery() async {
  ImagePicker picker = ImagePicker();
  await Permission.camera.request().isGranted;
  var status = await Permission.camera.status;
  if (status.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    print("Permission Denied");
  } else if (status.isGranted) {}

// You can can also directly ask the permission about its status.
  if (await Permission.camera.isRestricted) {
    print("Permission Restricted");
    // The OS restricts access, for example because of parental controls.
  } else {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    print("image is Selected");

    if (image != null) {
      print(image.path);
      return image;
    }
  }

  return null;
}
