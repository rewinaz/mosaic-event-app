import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController inputController;
  String? labelText;
  String? hintText;
  String? errorText;
  IconData? prefixIcon;
  TextInputType? textInputType;
  TextInputAction? textInputAction;
  Color? borderColor;
  Color? focusedBorderColor;
  Color? enabledBorderColor;
  Color? filledColor;
  double? borderRadius;
  bool? obsecureText;
  CustomTextField(
      {super.key,
      required this.inputController,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.errorText,
      this.textInputType,
      this.textInputAction,
      this.borderColor,
      this.focusedBorderColor,
      this.enabledBorderColor,
      this.filledColor,
      this.borderRadius,
      this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: inputController,
        keyboardType: textInputType ?? TextInputType.text,
        textInputAction: textInputAction ?? TextInputAction.next,
        obscureText: obsecureText ?? false,
        decoration: InputDecoration(
          filled: filledColor != null ? true : false,
          fillColor: filledColor ?? Colors.transparent,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          labelText: labelText ?? "",
          hintText: hintText ?? "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            borderSide: BorderSide(
              color: enabledBorderColor ?? Colors.grey,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            borderSide: BorderSide(
              color: focusedBorderColor ?? Colors.blue,
              width: 2,
            ),
          ),
          errorText: errorText,
        ),
      ),
    );
  }
}
