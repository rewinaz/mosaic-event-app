import 'package:flutter/material.dart';

class FetchedEventImage extends StatelessWidget {
  String imageSource;
  Function onTap;
  FetchedEventImage(
      {super.key, required this.imageSource, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
              imageSource,
              fit: BoxFit.cover,
              width: size,
              height: size,
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
}
