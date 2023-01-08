import 'package:event_app/components/custom_button_rounded.dart';
import 'package:event_app/components/event_detail/active_and_featured_view.dart';
import 'package:event_app/components/event_detail/info_text_with_icon.dart';
import 'package:event_app/controllers/event_controller.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/screens/update_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PosterUserScreen extends StatefulWidget {
  EventModel data;
  PosterUserScreen({super.key, required this.data});

  @override
  State<PosterUserScreen> createState() => _PosterUserScreenState();
}

class _PosterUserScreenState extends State<PosterUserScreen> {
  PageController _pageController = PageController();
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
        EventController.removeEvent(widget.data.docId!);
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
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    SizedBox(
                      height: 500,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.data.images.length,
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            widget.data.images[index],
                            width: double.infinity,
                            height: 500,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: const Alignment(0, 2),
                      margin: EdgeInsets.only(bottom: 10),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.data.images.length,
                        effect: const SlideEffect(
                          spacing: 8.0,
                          radius: 8.0,
                          dotWidth: 20.0,
                          dotHeight: 12.0,
                          paintStyle: PaintingStyle.stroke,
                          strokeWidth: 1.5,
                          dotColor: Colors.blueAccent,
                          activeDotColor: Colors.blueAccent,
                        ),
                      ),
                    )
                  ],
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(20),
                //   child: Image.network(
                //     widget.data.images.first,
                //     width: double.infinity,
                //     height: 500,
                //     fit: BoxFit.cover,
                //   ),
                // ),
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
                        widget.data.eventName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                        ),
                      ),

                      InfoCardWithActiveFeaturedIcon(
                        icon: Icons.toggle_on_outlined,
                        iconColor:
                            widget.data.isActive ? Colors.green : Colors.red,
                        textColor:
                            widget.data.isActive ? Colors.green : Colors.red,
                        title: "Active",
                        subTitle: widget.data.isActive
                            ? "Event is Active"
                            : "Event is Inactive",
                      ),
                      InfoCardWithActiveFeaturedIcon(
                        icon: Icons.featured_play_list_outlined,
                        iconColor:
                            widget.data.isFeatured ? Colors.green : Colors.red,
                        textColor:
                            widget.data.isActive ? Colors.green : Colors.red,
                        title: "Featured",
                        subTitle: widget.data.isActive
                            ? "Event is Featured"
                            : "Event is not Featured",
                      ),
                      InfoCardWithIcon(
                          icon: Icons.calendar_month,
                          title: "Today",
                          subTitle:
                              "${DateFormat("E, MMM d yyyy ( HH:mm )").format(widget.data.startDate)} - ${DateFormat("E, MMM d yyyy ( HH:mm )").format(widget.data.endDate)}"),
                      InfoCardWithIcon(
                        icon: Icons.attach_money_rounded,
                        title: widget.data.price > 0
                            ? "${widget.data.price} BR"
                            : "FREE",
                        subTitle: "Entrance Fee",
                      ),
                      InfoCardWithIcon(
                        icon: Icons.location_on,
                        title: widget.data.venueName,
                        subTitle: widget.data.venueAddress,
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
                                        UpdateEventScreen(data: widget.data))),
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
                        widget.data.description,
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
