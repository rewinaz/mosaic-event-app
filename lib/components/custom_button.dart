import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function buttonOnClick;
  String buttonText;
  bool? isFilled = true;
  Color? backgroundColor, textColor, borderColor;
  CustomButton({
    super.key,
    required this.buttonText,
    required this.buttonOnClick,
    this.isFilled,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isFilled == null || isFilled == true) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: MaterialButton(
          onPressed: () {
            buttonOnClick();
          },
          color: backgroundColor ?? const Color.fromRGBO(46, 137, 232, 1),
          minWidth: double.infinity,
          elevation: 0,
          height: 60,
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: borderColor ?? Colors.blue, width: 2),
        ),
        child: MaterialButton(
          onPressed: () {
            buttonOnClick();
          },
          color: Colors.transparent,
          minWidth: double.infinity,
          elevation: 0,
          height: 60,
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.blue,
            ),
          ),
        ),
      );
    }
  }
}
