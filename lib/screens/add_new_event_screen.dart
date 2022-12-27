import 'package:event_app/components/custom_datetime_selector.dart';
import 'package:event_app/components/custom_dropdown_selector.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewEventScreen extends StatefulWidget {
  const AddNewEventScreen({super.key});

  @override
  State<AddNewEventScreen> createState() => _AddNewEventScreenState();
}

class _AddNewEventScreenState extends State<AddNewEventScreen> {
  final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _startingDateController = TextEditingController();
  Color inputFillColor = Colors.white;
  Color inputBorderColor = Colors.white;
  double inputBorderRadius = 30.0;

  List<String> categories = ["Itemdsx1", "Item2hgf", "Item3rtefd"];

  // TODO Move This two functions to other file
  getDateFromUser() async {
    // TODO IMPLEMENT DATE SELECTION
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
      return "";
    }
  }

  getTimeFromUser() async {
    // TODO IMPLEMENT TIME SELECTION
    // getDateFromUser().then((text) => {print("" + text)});
    TimeOfDay? pickedTime =
        await showTimePicker(initialTime: TimeOfDay.now(), context: context);

    if (pickedTime != null) {
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      //output 1970-01-01 22:53:00.000
      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
      //DateFormat() is from intl package, you can format the time on any pattern you need.

      return formattedTime; //set the value of text field.
    } else {
      print("Time is not selected");
      return "";
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _eventTitleController.dispose();
    _startingDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Event Title Text Input
                CustomTextField(
                  inputController: _eventTitleController,
                  hintText: "Event Title",
                  labelText: "Event Title",
                  borderRadius: inputBorderRadius,
                  filledColor: inputFillColor,
                  borderColor: inputBorderColor,
                  enabledBorderColor: inputBorderColor,
                ),

                // TODO Event Category Selector
                CustomDropdownButton(
                  items: categories,
                  onChanged: () {},
                  hintText: "Event Category",
                ),

                // TODO Venue Text Input
                CustomTextField(
                  inputController: _eventTitleController,
                  hintText: "Venue Name",
                  labelText: "Venue Name",
                  borderRadius: inputBorderRadius,
                  filledColor: inputFillColor,
                  borderColor: inputBorderColor,
                  enabledBorderColor: inputBorderColor,
                ),

                // TODO Venue Address Input
                CustomTextField(
                  inputController: _eventTitleController,
                  hintText: "Venue Address",
                  labelText: "Venue Address",
                  borderRadius: inputBorderRadius,
                  filledColor: inputFillColor,
                  borderColor: inputBorderColor,
                  enabledBorderColor: inputBorderColor,
                ),

                //TODO Private or public radio button

                // TODO Start Date, End Date Custom Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDateTimeSelector(
                      controller: _startingDateController,
                      hintText: "Start Date",
                      suffixIcon: Icons.event,
                      onTap: () {},
                    ),
                    CustomDateTimeSelector(
                      controller: _startingDateController,
                      hintText: "End Date",
                      suffixIcon: Icons.event,
                      onTap: () {},
                    ),
                  ],
                ),

                // TODO Start Time, End Time Custom Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDateTimeSelector(
                      controller: _startingDateController,
                      hintText: "Start Time",
                      suffixIcon: Icons.timer_outlined,
                      onTap: () {},
                    ),
                    CustomDateTimeSelector(
                      controller: _startingDateController,
                      hintText: "End Time",
                      suffixIcon: Icons.timer_outlined,
                      onTap: () {},
                    ),
                  ],
                ),

                // TODO Event Image Selector And Display Custom

                // TODO Event Description Text Input

                // TODO: NEXT STEP BUTTON

                //TODO: Ticket Name TextField
                CustomTextField(
                  inputController: _eventTitleController,
                  hintText: "Ticket Name",
                  labelText: "Ticket Name",
                  borderRadius: inputBorderRadius,
                  filledColor: inputFillColor,
                  borderColor: inputBorderColor,
                  enabledBorderColor: inputBorderColor,
                ),

                //TODO Free and Paid ticket radio

                //TODO: Quantity input
                //TODO: Quantity Country
                //TODO: Quantity Currency

                // TODO Ticket Price input

                // TODO PREVIEW Button
                // TODO POST Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
