import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/home_screen/event_list_card.dart';
import 'package:event_app/components/home_screen/featured_event_card.dart';
import 'package:event_app/components/home_screen/section_title_bar.dart';
import 'package:event_app/controllers/event_controller.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/screens/event_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
          title: "Home",
          context: this.context,
        ),
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 280,
                  child: StreamBuilder<List<EventModel>>(
                    stream: EventController.getAllEvents(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                            "Something went wrong! ${snapshot.error.toString()}");
                      } else if (snapshot.hasData) {
                        final events = snapshot.data ?? [];
                        final filteredEvents = events
                            .where((element) =>
                                element.isFeatured == true &&
                                element.isActive == true)
                            .toList();
                        return filteredEvents.length > 0
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: filteredEvents.length,
                                itemBuilder: (context, index) =>
                                    FeaturedEventCard(
                                      data: filteredEvents[index],
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EventDetailScreen(
                                                    data:
                                                        filteredEvents[index])),
                                      ),
                                    ))
                            : Center(
                                child: Text(
                                    "There is no featured event at the moment."));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SectionTitleBar(
                  title: "Events",
                  onTap: () {},
                ),
                StreamBuilder<List<EventModel>>(
                    stream: EventController.getAllEvents(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                            "Something went wrong! ${snapshot.error.toString()}");
                      } else if (snapshot.hasData) {
                        final events = snapshot.data ?? [];
                        final filteredEvents = events
                            .where((element) => element.isActive == true)
                            .toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: filteredEvents.length,
                          itemBuilder: (context, index) => EventListCard(
                            data: filteredEvents[index],
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventDetailScreen(
                                      data: filteredEvents[index])),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
