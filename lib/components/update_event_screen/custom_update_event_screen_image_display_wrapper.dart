import 'package:flutter/material.dart';

class CustomNetworkImageDisplayWrapper extends StatefulWidget {
  List networkImages;
  Function onRemove;
  CustomNetworkImageDisplayWrapper({
    super.key,
    required this.networkImages,
    required this.onRemove,
  });

  @override
  State<CustomNetworkImageDisplayWrapper> createState() =>
      _CustomNetworkImageDisplayWrapperState();
}

class _CustomNetworkImageDisplayWrapperState
    extends State<CustomNetworkImageDisplayWrapper> {
  @override
  Widget build(BuildContext context) {
    List images = widget.networkImages;
    List removedImages = [];
    setState(() {
      images = widget.networkImages;
    });

    removeImage(String image) {
      images.remove(image);
      removedImages.add(image);
      widget.onRemove(images, removedImages);
      setState(() {
        images = images;
      });
    }

    showAlert(imageLink) {
      Widget cancelButton = TextButton(
        child: Text("No"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = TextButton(
        child: Text("Yes"),
        onPressed: () {
          Navigator.of(context).pop();
          removeImage(imageLink);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Alert"),
        content: Text(
          "Do you want to delete this Image?",
        ),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      return alert;
    }

    @override
    void initState() {
      super.initState();
      images = widget.networkImages;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Old Event Image",
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
              for (var item in images)
                buildImage(
                  onTap: () => {
                    showDialog(
                      context: context,
                      builder: (context) => showAlert(item),
                    )
                  },
                  imageLink: item,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildImage({
  required String imageLink,
  required Function onTap,
}) {
  double size = 110;
  return ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: size,
          width: size,
          child: Image.network(
            imageLink,
            fit: BoxFit.cover,
            cacheHeight: 110,
            cacheWidth: 110,
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
}
