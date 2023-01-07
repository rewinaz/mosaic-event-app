import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

getImageFromGallery() async {
  ImagePicker picker = ImagePicker();
  await Permission.camera.request().isGranted;
  var status = await Permission.camera.status;
  if (status.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
  } else if (status.isGranted) {}

// You can can also directly ask the permission about its status.
  if (await Permission.camera.isRestricted) {
    // The OS restricts access, for example because of parental controls.
  } else {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image;
    }
  }

  return null;
}
