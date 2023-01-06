import 'package:event_app/components/add_new_event_screen/custom_event_image_selector_wrapper.dart';
import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_button.dart';
import 'package:event_app/components/custom_datetime_selector.dart';
import 'package:event_app/components/custom_dropdown_selector.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:event_app/components/custom_text_field_multiline.dart';
import 'package:event_app/components/update_event_screen/custom_update_event_screen_image_display_wrapper.dart';
import 'package:event_app/controllers/event_controller.dart';
import 'package:event_app/helpers/date_selection_function.dart';
import 'package:event_app/helpers/form_validators.dart';
import 'package:event_app/helpers/custom_snack_bar.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateEventScreen extends StatefulWidget {
  EventModel data;
  UpdateEventScreen({super.key, required this.data});

  @override
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
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

  List<String> categories = ["Food", "Music", "Movie"];
  List<XFile> selectedImages = [];
  DateTime? startDate, endDate, startTime, endTime;
  String? selectedCategory;
  int uploadSize = 5;
  List oldImages = [];
  List removedImages = [];

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
    setState(() {
      selectedImages = images;
    });
  }

  setNetworkImages(List networkImages, List removedImages) {
    setState(() {
      oldImages = networkImages;
    });
    setRemovedImages(removedImages);
  }

  setRemovedImages(List removedImageLinks) {
    setState(() {
      removedImages = removedImageLinks;
    });
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
    if (selectedImages.length < 1 && oldImages.length < 1) {
      return Utils.showErrorSnackBar("Please Select at least one image.");
    }

    EventController.updateEvent(
      EventModel(
        docId: widget.data.docId,
        eventName: _eventTitleController.text.trim(),
        category: selectedCategory ?? "",
        venueName: _venueNameController.text.trim(),
        venueAddress: _venueAddressController.text.trim(),
        description: _descriptionController.text.trim(),
        isActive: widget.data.isActive,
        isFeatured: widget.data.isActive,
        quantity: int.parse(_quantityController.text.trim()),
        price: double.parse(_priceController.text.trim()),
        startDate: DateTimeUtils.getDateTimeFromTimeAndDate(
            date: startDate!, time: startTime!),
        endDate: DateTimeUtils.getDateTimeFromTimeAndDate(
            date: endDate!, time: endTime!),
        images: selectedImages,
        postedBy: currentUser.docId,
      ),
      oldImages,
      removedImages,
    );

    Navigator.pop(context);
    Navigator.pop(context);
  }

  setCategories(List<String> categoriesList) {
    setState(() {
      categories = categoriesList;
    });
  }

  @override
  void initState() {
    EventController.getAllCategories(setCategories);
    _eventTitleController.text = widget.data.eventName;
    _venueNameController.text = widget.data.venueName;
    _venueAddressController.text = widget.data.venueAddress;
    _priceController.text = widget.data.price.toString();
    _descriptionController.text = widget.data.description;
    _quantityController.text = widget.data.quantity.toString();
    _startingDateController.text =
        DateFormat.yMd().format(widget.data.startDate);
    _startingTimeController.text =
        DateFormat.Hm().format(widget.data.startDate);
    _endDateController.text = DateFormat.yMd().format(widget.data.endDate);
    _endTimeController.text = DateFormat.Hm().format(widget.data.endDate);

    selectedCategory = widget.data.category;
    oldImages = [];

    for (var element in widget.data.images) {
      oldImages.add(element);
    }
    oldImages = oldImages;
    selectedImages = [];
    uploadSize = 7 - oldImages.length;
    removedImages = [];

    startDate = widget.data.startDate;
    startTime = widget.data.startDate;
    endDate = widget.data.endDate;
    endTime = widget.data.endDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Update Event",
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
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
                  oldImages.length > 0
                      ? CustomNetworkImageDisplayWrapper(
                          onRemove: setNetworkImages,
                          networkImages: oldImages,
                        )
                      : Container(),
                  CustomImageSelector(
                    onNewImageAdded: setSelectedImages,
                    uploadSize: uploadSize,
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

                  const SizedBox(
                    height: 15,
                  ),
                  // TODO POST Button
                  CustomButton(
                    buttonText: "Update",
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
