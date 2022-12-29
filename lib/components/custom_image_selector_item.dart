import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageSelectorItem extends StatelessWidget {
  Function onTap;
  bool? isSelector;
  Color? borderColor;
  Color? iconColor;
  XFile? imageSource;
  CustomImageSelectorItem({
    super.key,
    required this.onTap,
    this.isSelector,
    this.borderColor,
    this.iconColor,
    this.imageSource,
  });

  @override
  Widget build(BuildContext context) {
    double size = 110;
    if (isSelector == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            imageSource != null
                ? Container(
                    height: size,
                    width: size,
                    child: Image.file(
                      File(imageSource!.path),
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: size,
                    width: size,
                    child: Image.asset(
                      "lib/assets/images/event_image.png",
                      fit: BoxFit.cover,
                    ),
                  ),
            GestureDetector(
              onTap: () => {onTap()},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red.shade600,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => {onTap()},
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor ?? Colors.blueGrey.shade200,
                strokeAlign: StrokeAlign.center,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            height: size,
            width: size,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  size: 50,
                  color: iconColor ?? Colors.blue,
                ),
                const Text(
                  "Add Image",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(54, 61, 78, 1),
                  ),
                )
              ],
            )),
      );
    }
  }
}
