import 'package:event_app/components/custom_button_rounded.dart';
import 'package:event_app/components/event_detail/info_text_with_icon.dart';
import 'package:event_app/controllers/event_controller.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/screens/update_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PosterUserScreen extends StatelessWidget {
  EventModel data;
  PosterUserScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        EventController.removeEvent(data.docId!);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
        "Do you want to delete this event?",
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    data.images.first,
                    width: double.infinity,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data.eventName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                        ),
                      ),
                      InfoCardWithIcon(
                          icon: Icons.calendar_month,
                          title: "Today",
                          subTitle:
                              "${DateFormat("E, MMM d yyyy ( HH:mm )").format(data.startDate)} - ${DateFormat("E, MMM d yyyy ( HH:mm )").format(data.endDate)}"),
                      InfoCardWithIcon(
                        icon: Icons.attach_money_rounded,
                        title: data.price > 0 ? "${data.price} BR" : "FREE",
                        subTitle: "Entrance Fee",
                      ),
                      InfoCardWithIcon(
                        icon: Icons.location_on,
                        title: data.venueName,
                        subTitle: data.venueAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButtonRounded(
                            buttonText: "Delete",
                            backgroundColor: Colors.redAccent, // height: 50
                            buttonOnClick: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => alert);
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomButtonRounded(
                            buttonText: "Update",
                            buttonOnClick: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateEventScreen(data: data))),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      const Text(
                        "About",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.description,
                        softWrap: true,
                        maxLines: 100,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),

                      // Profile
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
