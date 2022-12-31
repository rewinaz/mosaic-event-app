import 'package:event_app/components/custom_image_selector_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomImageSelector extends StatefulWidget {
  Function onNewImageAdded;
  CustomImageSelector({super.key, required this.onNewImageAdded});

  @override
  State<CustomImageSelector> createState() => _CustomImageSelectorState();
}

class _CustomImageSelectorState extends State<CustomImageSelector> {
  List<XFile> selectedImages = [];
  int selectedImagesMaxSize = 7;

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
        selectedImages.add(image);
        widget.onNewImageAdded(selectedImages);
        setState(() {
          selectedImages = selectedImages;
        });
      }
    }
  }

  removeImage(XFile image) {
    selectedImages.remove(image);
    widget.onNewImageAdded(selectedImages);
    setState(() {
      selectedImages = selectedImages;
    });
  }

  @override
  void initState() {
    selectedImages = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Event Image",
            style: TextStyle(
              color: Color.fromRGBO(54, 61, 78, 1),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            runSpacing: 10,
            spacing: 10,
            children: [
              for (var item in selectedImages)
                CustomImageSelectorItem(
                  onTap: () => {removeImage(item)},
                  imageSource: item,
                ),
              selectedImages.length < selectedImagesMaxSize
                  ? CustomImageSelectorItem(
                      onTap: getImageFromGallery,
                      isSelector: true,
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
