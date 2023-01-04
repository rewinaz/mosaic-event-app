import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static Future<DateTime?> getDateFromUser(BuildContext context) async {
    // Make sure it returns DateTime object

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      return pickedDate;
    } else {
      return null;
    }
  }

  static Future<DateTime?> getTimeFromUser(BuildContext context) async {
    // Make sure it returns DateTime object
    TimeOfDay? pickedTime =
        await showTimePicker(initialTime: TimeOfDay.now(), context: context);

    if (pickedTime != null) {
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      return parsedTime; //set the value of text field.
    } else {
      return null;
    }
  }

  static DateTime getDateTimeFromTimeAndDate(
      {required DateTime date, required DateTime time}) {
    return DateTime.utc(
        date.year, date.month, date.day, time.hour, time.minute, time.second);
  }
}
