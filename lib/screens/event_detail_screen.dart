import 'package:event_app/components/custom_button_rounded.dart';
import 'package:event_app/components/event_detail/info_text_with_icon.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatelessWidget {
  EventModel data;
  EventDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
                            buttonText: "Save",
                            buttonOnClick: () {},
                            backgroundColor: Colors.lightGreen, // height: 50
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomButtonRounded(
                            buttonText: "Book Now",
                            buttonOnClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(data: data))),
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
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: SizedBox(
                                width: 90,
                                height: 90,
                                child: Image.asset(
                                  "lib/assets/images/event_image.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            const Text(
                              "Palmy Lounge",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      )
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
