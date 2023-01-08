import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:event_app/components/home_screen/event_list_card.dart';
import 'package:event_app/components/home_screen/section_title_bar.dart';
import 'package:event_app/controllers/event_controller.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/screens/event_detail_screen.dart';
import 'package:flutter/material.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  TextEditingController _searchKeyController = TextEditingController();
  String searchKey = "";

  onFieldChanged(String value) {
    setState(() {
      searchKey = value.toLowerCase().trim();
    });
  }

  @override
  void initState() {
    super.initState();
    searchKey = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Search Results",
        leadingIcon: Icons.arrow_back_ios,
        leadingOnTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: TextFormField(
                autofocus: true,
                onChanged: (value) => onFieldChanged(value),
                controller: _searchKeyController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search Event",
                  hintText: "Search Event",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            SectionTitleBar(
              title: "Search Results",
              onTap: () {},
            ),
            searchKey.length > 0
                ? StreamBuilder<List<EventModel>>(
                    stream: EventController.getAllEvents(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                            "Something went wrong! ${snapshot.error.toString()}");
                      } else if (snapshot.hasData) {
                        print("SEARCH");
                        final events = snapshot.data ?? [];
                        final filteredEvents = events
                            .where((element) =>
                                element.isActive == true &&
                                element.eventName
                                    .startsWith(searchKey.trim().toLowerCase()))
                            .toList();

                        return filteredEvents.length > 0
                            ? ListView.builder(
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
                              )
                            : const Center(
                                child: Text("No Event With That Name."),
                              );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
                : const Center(
                    child: Text("Please enter event name to be searched."),
                  ),
          ],
        ),
      ),
    );
  }
}
