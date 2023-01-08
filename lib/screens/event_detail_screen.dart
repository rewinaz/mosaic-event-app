import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/components/custom_button_rounded.dart';
import 'package:event_app/components/event_detail/info_text_with_icon.dart';
import 'package:event_app/controllers/event_controller.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/models/user_model.dart';
import 'package:event_app/screens/checkout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventDetailScreen extends StatelessWidget {
  EventModel data;
  EventDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();

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
                        itemCount: data.images.length,
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            data.images[index],
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
                        count: data.images.length,
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
                //     data.images.first,
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
                          // CustomButtonRounded(
                          //   buttonText: "Save",
                          //   buttonOnClick: () {},
                          //   backgroundColor: Colors.lightGreen, // height: 50
                          // ),
                          // const SizedBox(
                          //   width: 20,
                          // ),
                          CustomButtonRounded(
                            buttonText: "Book Now",
                            buttonOnClick: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CheckoutScreen(data: data))),
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
                        child: FutureBuilder<UserModel>(
                            future: FirebaseFirestore.instance
                                .collection("users")
                                .doc(data.postedBy)
                                .snapshots()
                                .map((event) => UserModel(
                                      fullName: event.get("fullName"),
                                      imageLink: event.get("imageLink"),
                                      phoneNumber: event.get("phone"),
                                      email: event.get("email"),
                                      docId: event.id,
                                    ))
                                .first,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                UserModel? postedBy = snapshot.data;
                                print(postedBy?.imageLink);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: SizedBox(
                                        width: 90,
                                        height: 90,
                                        child: CachedNetworkImage(
                                          useOldImageOnUrlChange: true,
                                          imageUrl: postedBy?.imageLink ?? "",
                                          placeholder: (context, url) =>
                                              errorImage(),
                                          errorWidget: (context, url, error) =>
                                              errorImage(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      postedBy?.fullName ?? "",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        // const Text(
                        //   "Palmy Lounge",
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.w900,
                        //     fontSize: 24,
                        //   ),
                        // ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget errorImage() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      width: 90,
      height: 90,
      color: Colors.grey.shade300,
      child: Icon(
        Icons.person,
        color: Colors.black,
        size: 80,
      ),
    ),
  );
}
