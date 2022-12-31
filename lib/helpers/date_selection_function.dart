import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

getDateFromUser(BuildContext context) async {
  // TODO Make sure it returns DateTime object

  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2100));
  if (pickedDate != null) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(
        pickedDate); //formatted date output using intl package =>  2021-03-16

    return formattedDate;
  } else {
    return "Select again";
  }
}

getTimeFromUser(BuildContext context) async {
  // TODO Make sure it returns DateTime object
  TimeOfDay? pickedTime =
      await showTimePicker(initialTime: TimeOfDay.now(), context: context);

  if (pickedTime != null) {
    print(pickedTime.format(context)); //output 10:51 PM
    DateTime parsedTime =
        DateFormat.jm().parse(pickedTime.format(context).toString());
    //converting to DateTime so that we can further format on different pattern.
    //output 1970-01-01 22:53:00.000
    String formattedTime = DateFormat('HH:mm').format(parsedTime);
    //DateFormat() is from intl package, you can format the time on any pattern you need.

    return formattedTime; //set the value of text field.
  } else {
    return "Select again";
  }
}
