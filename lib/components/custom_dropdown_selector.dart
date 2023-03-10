import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  List<String> items;
  Function onChanged;

  Color? fillColor, iconColor, borderColor;
  double? borderRadius;
  String hintText;
  CustomDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.fillColor,
    this.iconColor,
    this.borderRadius,
    this.borderColor,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedItem = "";

  Color defaultBorderColor = Colors.white;
  double defaultBorderRadius = 40;


  @override
  Widget build(BuildContext context) {
    OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(widget.borderRadius ?? defaultBorderRadius),
      borderSide:
          BorderSide(color: widget.borderColor ?? defaultBorderColor, width: 2),
    );

    return DropdownButtonFormField<String>(
      hint: Text(
        widget.hintText,
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
      items: widget.items
          .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              )))
          .toList(),
      onChanged: (value) {
        widget.onChanged(value);
        setState(() => {selectedItem = value});
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor ?? Colors.white,
        border: borderStyle,
        enabledBorder: borderStyle,
        focusedBorder: borderStyle,
      ),
    );
  }
}
