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
    int length = 5;
    TabController _controller = TabController(length: length, vsync: this);
    List<String> categories = ["All", "Featured", "Food", "Music", "Movie"];

    setCategories(List<String> categoriesList) {
      setState(() {
        categories = categoriesList;
      });
    }

    @override
    void initState() {
      EventController.getAllCategories(setCategories);
      super.initState();
      _controller = TabController(length: length, vsync: this);
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
                  for (int i = 0; i < _controller.length; i++)
                    Tab(
                      text: categories[i],
                    ),
                ],
                labelColor: Colors.black,
                // add it here

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
                    for (int i = 0; i < _controller.length; i++)
                      StreamBuilder<List<EventModel>>(
                          stream: EventController.getAllEvents(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                "Something went wrong! ${snapshot.error.toString()}",
                              );
                            } else if (snapshot.hasData) {
                              final events = snapshot.data ?? [];
                              final category = i == 0 ? "" : categories[i];
                              List filteredEvents = [];
                              if (i < 2) {
                                if (i == 0) {
                                  filteredEvents = events
                                      .where(
                                        (element) => element.isActive == true,
                                      )
                                      .toList();
                                } else {
                                  filteredEvents = events
                                      .where(
                                        (element) =>
                                            element.isActive == true &&
                                            element.isFeatured == true,
                                      )
                                      .toList();
                                }
                              } else {
                                filteredEvents = events
                                    .where((element) =>
                                        element.isActive == true &&
                                        element.category == category)
                                    .toList();
                              }
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
            ],
          ),
        ),
      ),
    );
  }
}
