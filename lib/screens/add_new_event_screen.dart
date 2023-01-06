import 'package:event_app/components/add_new_event_screen/custom_event_image_selector_wrapper.dart';
import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_button.dart';
import 'package:event_app/components/custom_datetime_selector.dart';
import 'package:event_app/components/custom_dropdown_selector.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:event_app/components/custom_text_field_multiline.dart';
import 'package:event_app/controllers/event_controller.dart';
import 'package:event_app/helpers/date_selection_function.dart';
import 'package:event_app/helpers/form_validators.dart';
import 'package:event_app/helpers/custom_snack_bar.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddNewEventScreen extends StatefulWidget {
  const AddNewEventScreen({super.key});

  @override
  State<AddNewEventScreen> createState() => _AddNewEventScreenState();
}

class _AddNewEventScreenState extends State<AddNewEventScreen> {
  final newEventFormKey = GlobalKey<FormState>();
  final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _venueNameController = TextEditingController();
  final TextEditingController _venueAddressController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _startingDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startingTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  Color inputFillColor = Colors.white;
  Color inputBorderColor = Colors.white;
  double inputBorderRadius = 30.0;

  // List<String> categories = ["Food", "Music", "Movie"];
  List<String> categories = [];
  List<XFile> selectedImages = [];
  DateTime? startDate, endDate, startTime, endTime;
  String? selectedCategory;

  getStartDate(TextEditingController controller) async {
    DateTime? date = await DateTimeUtils.getDateFromUser(context);
    if (date != null) {
      startDate = date;
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      controller.text = formattedDate;
    }
  }

  getendDate(TextEditingController controller) async {
    DateTime? date = await DateTimeUtils.getDateFromUser(context);
    if (date != null) {
      endDate = date;
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      controller.text = formattedDate;
    }
  }

  getStartTime(TextEditingController controller) async {
    DateTime? time = await DateTimeUtils.getTimeFromUser(context);
    if (time != null) {
      startTime = time;
      String formattedTime = DateFormat('HH:mm').format(time);
      controller.text = formattedTime;
    }
  }

  getEndTime(TextEditingController controller) async {
    DateTime? time = await DateTimeUtils.getTimeFromUser(context);
    if (time != null) {
      endTime = time;
      String formattedTime = DateFormat('HH:mm').format(time);
      controller.text = formattedTime;
    }
  }

  getDateTimeFromTimeAndDate({required DateTime date, required DateTime time}) {
    return DateTime.utc(
        date.year, date.month, date.day, time.hour, time.minute, time.second);
  }

  getCategory(String value) {
    selectedCategory = value;
  }

  setSelectedImages(List<XFile> images) {
    selectedImages = images;
  }

  postNowButtonOnTapHandler(BuildContext context) {
    final isValid = newEventFormKey.currentState!.validate();
    if (!isValid) return;

    if (selectedCategory == null) {
      return Utils.showErrorSnackBar("Please Select category.");
    }
    if (startDate == null ||
        startTime == null ||
        endDate == null ||
        endTime == null) {
      return Utils.showErrorSnackBar("Please fill all dates.");
    }
    if (selectedImages.length < 1) {
      return Utils.showErrorSnackBar("Please Select at least one image.");
    }

    EventController.saveEventToFireStore(
      EventModel(
        eventName: _eventTitleController.text.trim(),
        category: selectedCategory ?? "",
        venueName: _venueNameController.text.trim(),
        venueAddress: _venueAddressController.text.trim(),
        description: _descriptionController.text.trim(),
        isActive: false,
        isFeatured: false,
        quantity: int.parse(_quantityController.text.trim()),
        price: double.parse(_priceController.text.trim()),
        startDate: DateTimeUtils.getDateTimeFromTimeAndDate(
            date: startDate!, time: startTime!),
        endDate: DateTimeUtils.getDateTimeFromTimeAndDate(
            date: endDate!, time: endTime!),
        images: selectedImages,
        postedBy: currentUser.docId,
      ),
    );
    Navigator.pop(context);
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   _eventTitleController.dispose();
  //   _startingDateController.dispose();
  //   _endDateController.dispose();
  //   _startingTimeController.dispose();
  //   _endTimeController.dispose();
  //   _descriptionController.dispose();

  //   _venueNameController.dispose();
  //   _venueAddressController.dispose();
  //   _quantityController.dispose();
  //   _priceController.dispose();
  //   super.dispose();
  // }

  setCategories(List<String> categoriesList) {
    setState(() {
      categories = categoriesList;
    });
  }

  @override
  void initState() {
    super.initState();
    EventController.getAllCategories(setCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: "Create New Event",
          leadingIcon: Icons.arrow_back_ios_new_rounded,
          leadingOnTap: () {
            Navigator.pop(context);
          }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: newEventFormKey,
              child: Column(
                children: [
                  // Event Title Text Input
                  CustomTextField(
                    inputController: _eventTitleController,
                    labelText: "Event Title",
                    filledColor: inputFillColor,
                    borderRadius: inputBorderRadius,
                    enabledBorderColor: inputBorderColor,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => FormValidators.isEmpty(value),
                  ),

                  // TODO Event Category Selector
                  CustomDropdownButton(
                    items: categories,
                    onChanged: getCategory,
                    hintText: "Select Category",
                  ),

                  // TODO Venue Text Input
                  CustomTextField(
                    inputController: _venueNameController,
                    hintText: "Venue Name",
                    labelText: "Venue Name",
                    borderRadius: inputBorderRadius,
                    filledColor: inputFillColor,
                    borderColor: inputBorderColor,
                    enabledBorderColor: inputBorderColor,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => FormValidators.isEmpty(value),
                  ),

                  // TODO Venue Address Input
                  CustomTextField(
                    inputController: _venueAddressController,
                    hintText: "Venue Address",
                    labelText: "Venue Address",
                    borderRadius: inputBorderRadius,
                    filledColor: inputFillColor,
                    borderColor: inputBorderColor,
                    enabledBorderColor: inputBorderColor,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => FormValidators.isEmpty(value),
                  ),

                  // TODO Start Date, End Date Custom Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDateTimeSelector(
                        controller: _startingDateController,
                        hintText: "Start Date",
                        suffixIcon: Icons.event,
                        onTap: getStartDate,
                      ),
                      CustomDateTimeSelector(
                        controller: _endDateController,
                        hintText: "End Date",
                        suffixIcon: Icons.event,
                        onTap: getendDate,
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
                        onTap: getStartTime,
                      ),
                      CustomDateTimeSelector(
                        controller: _endTimeController,
                        hintText: "End Time",
                        suffixIcon: Icons.timer_outlined,
                        onTap: getEndTime,
                      ),
                    ],
                  ),

                  // TODO Event Image Selector And Display Custom
                  CustomImageSelector(
                    onNewImageAdded: setSelectedImages,
                    uploadSize: 5,
                  ),

                  // TODO Event Description Text Input
                  CustomMultiLineTextField(
                    inputController: _descriptionController,
                    hintText: "Description",
                    labelText: "Description",
                    borderRadius: 15,
                    filledColor: inputFillColor,
                    borderColor: inputBorderColor,
                    enabledBorderColor: inputBorderColor,
                    textInputType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => FormValidators.isEmpty(value),
                  ),

                  //TODO Quantity input
                  CustomTextField(
                    inputController: _quantityController,
                    hintText: "Ticket Quantity",
                    labelText: "Quantity",
                    borderRadius: inputBorderRadius,
                    filledColor: inputFillColor,
                    borderColor: inputBorderColor,
                    enabledBorderColor: inputBorderColor,
                    textInputType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => FormValidators.isEmpty(value),
                  ),

                  // TODO Ticket Price input
                  CustomTextField(
                    inputController: _priceController,
                    hintText: "Ticket Price",
                    labelText: "Ticket Price",
                    borderRadius: inputBorderRadius,
                    filledColor: inputFillColor,
                    borderColor: inputBorderColor,
                    enabledBorderColor: inputBorderColor,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => FormValidators.isEmpty(value),
                  ),

                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // TODO PREVIEW Button
                  // CustomButton(
                  //   buttonText: "Preview",
                  //   buttonOnClick: () {
                  //     // TODO: HANDLE PREVIEW
                  //   },
                  //   isFilled: false,
                  // ),

                  const SizedBox(
                    height: 15,
                  ),
                  // TODO POST Button
                  CustomButton(
                    buttonText: "Post Now",
                    buttonOnClick: () {
                      postNowButtonOnTapHandler(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
