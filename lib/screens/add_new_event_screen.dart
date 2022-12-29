import 'package:event_app/components/add_new_event_screen/custom_event_image_selector_wrapper.dart';
import 'package:event_app/components/add_new_event_screen/custom_radio_buttons.dart';
import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_datetime_selector.dart';
import 'package:event_app/components/custom_dropdown_selector.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:event_app/helper_functions/date_selection_function.dart';
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
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startingTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  Color inputFillColor = Colors.white;
  Color inputBorderColor = Colors.white;
  double inputBorderRadius = 30.0;

  List<String> categories = ["Itemdsx1", "Item2hgf", "Item3rtefd"];

  // TODO Move This two functions to other file

  getDate(TextEditingController controller) async {
    String date = await getDateFromUser(context);
    setState(() {
      controller.text = date;
    });
  }

  getTime(TextEditingController controller) async {
    String time = await getTimeFromUser(context);
    controller.text = time;
  }

  @override
  void initState() {
    _startingDateController.text = "";
    _endDateController.text = "";
    _startingTimeController.text = "";
    _endTimeController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _eventTitleController.dispose();
    _startingDateController.dispose();
    _endDateController.dispose();
    _startingTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: "Create Event",
          leadingIcon: Icons.arrow_back_ios_new_rounded,
          leadingOnTap: () {
            // TODO Implement onTap
          }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                CustomRadioButtons(
                  value: "",
                  groupValue: "groupValue",
                  onChanged: () {},
                ),

                // TODO Start Date, End Date Custom Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDateTimeSelector(
                      controller: _startingDateController,
                      hintText: "Start Date",
                      suffixIcon: Icons.event,
                      onTap: getDate,
                    ),
                    CustomDateTimeSelector(
                      controller: _endDateController,
                      hintText: "End Date",
                      suffixIcon: Icons.event,
                      onTap: getDate,
                    ),
                  ],
                ),

                // TODO Start Time, End Time Custom Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDateTimeSelector(
                      controller: _startingTimeController,
                      hintText: "Start Time",
                      suffixIcon: Icons.timer_outlined,
                      onTap: getTime,
                    ),
                    CustomDateTimeSelector(
                      controller: _endTimeController,
                      hintText: "End Time",
                      suffixIcon: Icons.timer_outlined,
                      onTap: getTime,
                    ),
                  ],
                ),

                // TODO Event Image Selector And Display Custom
                CustomImageSelector(),

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
                CustomTextField(
                  inputController: _eventTitleController,
                  hintText: "Ticket Price",
                  labelText: "Ticket Price",
                  borderRadius: inputBorderRadius,
                  filledColor: inputFillColor,
                  borderColor: inputBorderColor,
                  enabledBorderColor: inputBorderColor,
                ),

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
