import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/home_screen/event_list_card.dart';
import 'package:event_app/controllers/event_controller.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/screens/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _controller = TabController(length: 4, vsync: this);
    List<String> categories = ["All", "Food", "Music", "Movie"];

setCategories(List<String> categoriesList) {
      setState(() {
        categories = categoriesList;
      });
    }
    @override
    void initState() {
      EventController.getAllCategories(setCategories);
      super.initState();
      _controller = TabController(length: 4, vsync: this);
    }

    return Scaffold(
      appBar: customAppBar(context: context, title: "Explore"),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              TabBar(
                controller: _controller,
                isScrollable: true,
                indicatorColor: Colors.green,
                tabs: [
                  Tab(
                    text: "All",
                  ),
                  Tab(
                    text: "Food",
                  ),
                  Tab(
                    text: "Music",
                  ),
                  Tab(
                    text: "Movies",
                  ),
                ],
                labelColor: Colors.black,
                // add it here
                // indicator: DotIndicator(
                //   color: Colors.black,
                //   distanceFromCenter: 16,
                //   radius: 3,
                //   paintingStyle: PaintingStyle.fill,
                // ),
                // indicator: RectangularIndicator(
                //   bottomLeftRadius: 50,
                //   bottomRightRadius: 50,
                //   topLeftRadius: 50,
                //   topRightRadius: 50,
                //   paintingStyle: PaintingStyle.fill,
                // ),
                indicator: MaterialIndicator(
                  height: 5,
                  topLeftRadius: 0,
                  topRightRadius: 0,
                  bottomLeftRadius: 5,
                  bottomRightRadius: 5,
                  tabPosition: TabPosition.bottom,
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    for (int i = 0; i < 4; i++)
                      StreamBuilder<List<EventModel>>(
                          stream: EventController.getAllEvents(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  "Something went wrong! ${snapshot.error.toString()}");
                            } else if (snapshot.hasData) {
                              final events = snapshot.data ?? [];
                              final category = i == 0 ? "" : categories[i];
                              List filteredEvents = [];
                              i == 0
                                  ? filteredEvents = events
                                      .where(
                                        (element) => element.isActive == true,
                                      )
                                      .toList()
                                  : filteredEvents = events
                                      .where((element) =>
                                          element.isActive == true &&
                                          element.category == category)
                                      .toList();
                              return filteredEvents.length > 0
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: filteredEvents.length,
                                      itemBuilder: (context, index) =>
                                          EventListCard(
                                        data: filteredEvents[index],
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EventDetailScreen(
                                                      data: filteredEvents[
                                                          index])),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text("List is empty."),
                                    );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                  ],
                ),
              )

              // Content

              // SectionTitleBar(
              //   title: "Events",
              //   onTap: () {},
              // ),

              // DefaultTabController(
              //   length: 4,
              //   child: TabBarView(
              //     children: [
              //       StreamBuilder<List<EventModel>>(
              //           stream: EventController.getAllEvents(),
              //           builder: (context, snapshot) {
              //             if (snapshot.hasError) {
              //               return Text(
              //                   "Something went wrong! ${snapshot.error.toString()}");
              //             } else if (snapshot.hasData) {
              //               final events = snapshot.data ?? [];
              //               final filteredEvents = events
              //                   .where((element) => element.isActive == true)
              //                   .toList();
              //               return ListView.builder(
              //                 shrinkWrap: true,
              //                 primary: false,
              //                 itemCount: filteredEvents.length,
              //                 itemBuilder: (context, index) => EventListCard(
              //                   data: filteredEvents[index],
              //                   onTap: () => Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) => EventDetailScreen(
              //                             data: filteredEvents[index])),
              //                   ),
              //                 ),
              //               );
              //             } else {
              //               return Center(
              //                 child: CircularProgressIndicator(),
              //               );
              //             }
              //           }),
              //     ],
              //   ),
              // ),

              // TabBarView(
              //   children: [
              //     ListView.builder(
              //   shrinkWrap: true,
              //   primary: false,
              //   itemCount: 10,
              //   itemBuilder: (context, index) => EventListCard(
              //     imagePath: "lib/assets/images/event_image.png",
              //     title: "USA Singing Competition",
              //     location: "Marina Hall, Toronto",
              //     date: "Sun, May 2022, at 11:00 AM",
              //     price: 100,
              //     onTap: () {},
              //   ),
              // ),

              // ListView.builder(
              //   shrinkWrap: true,
              //   primary: false,
              //   itemCount: 10,
              //   itemBuilder: (context, index) => EventListCard(
              //     imagePath: "lib/assets/images/event_image.png",
              //     title: "USA Singing Competition",
              //     location: "Marina Hall, Toronto",
              //     date: "Sun, May 2022, at 11:00 AM",
              //     price: 100,
              //     onTap: () {},
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
