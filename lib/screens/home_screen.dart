import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_bottom_navigation_bar.dart';
import 'package:event_app/components/home_screen/category_card.dart';
import 'package:event_app/components/home_screen/event_list_card.dart';
import 'package:event_app/components/home_screen/featured_event_card.dart';
import 'package:event_app/components/home_screen/section_title_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomAppBar(),
        appBar: customAppBar(
          title: "Home",
          context: this.context,
          leadingIcon: Icons.menu,
          leadingOnTap: () {
            // TODO Implement OnTap
          },
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Column(
            children: [
              SizedBox(
                height: 280,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // TODO lists.builder
                    FeaturedEventCard(
                      imagePath: "lib/assets/images/event_image.png",
                      eventTitle: "Marryland Event",
                      eventDescription: "Beach View Park, Toronto",
                      eventDate: "20 Mar",
                    ),
                    FeaturedEventCard(
                      imagePath: "lib/assets/images/event_image.png",
                      eventTitle: "Marryland Event",
                      eventDescription: "Beach View Park, Toronto",
                      eventDate: "20 Mar",
                    ),
                    FeaturedEventCard(
                      imagePath: "lib/assets/images/event_image.png",
                      eventTitle: "Marryland Event",
                      eventDescription: "Beach View Park, Toronto",
                      eventDate: "20 Mar",
                    ),
                  ],
                ),
              ),

              // category Of events
              // Title
              SectionTitleBar(
                title: "Categories",
                onTap: () {},
              ),
              // Content

              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // TODO lists.builder
                    CategoryCard(
                      imagePath: "lib/assets/images/food_category.png",
                      title: "Food Event",
                      onTap: () {},
                    ),
                    CategoryCard(
                      imagePath: "lib/assets/images/music_category.png",
                      title: "Music Event",
                      onTap: () {},
                    ),
                    CategoryCard(
                      imagePath: "lib/assets/images/movie_category.png",
                      title: "Movie Event",
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SectionTitleBar(
                title: "Upcoming Events",
                onTap: () {},
              ),

              Expanded(
                child: ListView(
                  children: [
                    EventListCard(
                      imagePath: "lib/assets/images/event_image.png",
                      title: "USA Singing Competition",
                      location: "Marina Hall, Toronto",
                      date: "Sun, May 2022, at 11:00 AM",
                    ),
                    EventListCard(
                      imagePath: "lib/assets/images/event_image.png",
                      title: "USA Singing Competition",
                      location: "Marina Hall, Toronto",
                      date: "Sun, May 2022, at 11:00 AM",
                    ),
                    EventListCard(
                      imagePath: "lib/assets/images/event_image.png",
                      title: "USA Singing Competition",
                      location: "Marina Hall, Toronto",
                      date: "Sun, May 2022, at 11:00 AM",
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
