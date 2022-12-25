import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function buttonOnClick;
  String buttonText;
  bool isFilled = true;
  CustomButton({
    super.key,
    required this.buttonText,
    required this.buttonOnClick,
    required this.isFilled,
  });

  @override
  Widget build(BuildContext context) {
    if (isFilled) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: MaterialButton(
          onPressed: () {
            buttonOnClick();
          },
          color: const Color.fromRGBO(46, 137, 232, 1),
          minWidth: double.infinity,
          elevation: 0,
          height: 60,
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.blue, width: 3),
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
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      );
    }
  }
}
