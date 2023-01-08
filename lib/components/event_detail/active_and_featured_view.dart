import 'package:flutter/material.dart';

class InfoCardWithActiveFeaturedIcon extends StatelessWidget {
  String title, subTitle;
  IconData icon;
  Color? iconColor, textColor;
  InfoCardWithActiveFeaturedIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: iconColor ?? Colors.grey.shade700,
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textColor ?? Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(subTitle),
            ],
          )
        ],
      ),
    );
  }
}
