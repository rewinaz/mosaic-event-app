import 'package:flutter/material.dart';

class CustomButtonRounded extends StatelessWidget {
  Function buttonOnClick;
  String buttonText;
  bool? isFilled = true;
  Color? backgroundColor, textColor, borderColor;
  CustomButtonRounded({
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
      return Flexible(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: MaterialButton(
            onPressed: () {
              buttonOnClick();
            },
            color: backgroundColor ?? const Color.fromRGBO(46, 137, 232, 1),
            minWidth: double.infinity,
            elevation: 0,
            height: 50,
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
        ),
      );
    } else {
      return Flexible(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: borderColor ?? Colors.blue, width: 2),
          ),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            focusColor: Color.fromARGB(0, 255, 255, 255),
            splashColor: Colors.grey.shade300,
            hoverElevation: 0,
            focusElevation: 0,
            onPressed: () {
              buttonOnClick();
            },
            color: Colors.transparent,
            minWidth: double.infinity,
            elevation: 0,
            height: 50,
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
        ),
      );
    }
  }
}
