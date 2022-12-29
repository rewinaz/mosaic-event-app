import 'package:flutter/material.dart';

class CustomDateTimeSelector extends StatefulWidget {
  TextEditingController controller;
  Color? fillColor, iconColor, borderColor;
  double? borderRadius;
  IconData? suffixIcon;
  Function onTap;
  String hintText;
  CustomDateTimeSelector({
    super.key,
    required this.controller,
    required this.hintText,
    this.fillColor,
    this.iconColor,
    this.borderRadius,
    this.borderColor,
    this.suffixIcon,
    required this.onTap,
  });

  @override
  State<CustomDateTimeSelector> createState() => _CustomDateTimeSelectorState();
}

class _CustomDateTimeSelectorState extends State<CustomDateTimeSelector> {
  @override
  Widget build(BuildContext context) {
    Color defaultBorderColor = Colors.white;
    double defaultBorderRadius = 40;

    TextEditingController _dateTimeSelectorController = widget.controller;

    @override
    void initState() {
      super.initState();
      _dateTimeSelectorController = widget.controller;
    }

    OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(widget.borderRadius ?? defaultBorderRadius),
      borderSide: BorderSide(
        color: widget.borderColor ?? defaultBorderColor,
        width: 2,
      ),
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 160,
      child: TextField(
        controller: _dateTimeSelectorController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          filled: true,
          fillColor: widget.fillColor ?? Colors.white,
          border: borderStyle,
          enabledBorder: borderStyle,
          focusedBorder: borderStyle,
          suffixIcon: Icon(
            widget.suffixIcon ?? Icons.event,
            color: widget.iconColor ?? Colors.red,
          ),
        ),
        onTap: () {
          setState(() {
            widget.onTap(widget.controller);
          });
        },
      ),
    );
  }
}
