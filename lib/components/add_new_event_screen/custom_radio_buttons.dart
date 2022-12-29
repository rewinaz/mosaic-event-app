import 'package:flutter/material.dart';

class CustomRadioButtons extends StatelessWidget {
  String value;
  String groupValue;
  Function onChanged;
  CustomRadioButtons({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // RadioListTile(
        //   value: value,
        //   groupValue: groupValue,
        //   title: Text("Private"),
        //   onChanged: (val) => {onChanged()},
        // ),
      ],
    );
  }
}
