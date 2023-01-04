import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/home_screen/event_list_card.dart';
import 'package:event_app/components/home_screen/section_title_bar.dart';
import 'package:event_app/controllers/event_controller.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/screens/event_detail_screen.dart';
import 'package:event_app/screens/poster_user_screen.dart';
import 'package:event_app/screens/update_event_screen.dart';
import 'package:event_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    showAlert(String? docId) {
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
          EventController.removeEvent(docId!);
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
      return alert;
    }

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Dashboard",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SectionTitleBar(title: "Posted Events", onTap: () {}),
              const SizedBox(
                height: 15,
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
                          .where((element) =>
                              element.postedBy == currentUser.docId)
                          .toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: filteredEvents.length,
                        itemBuilder: (context, index) => Slidable(
                          key: const ValueKey(0),
                          startActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        showAlert(filteredEvents[index].docId),
                                  );
                                },
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateEventScreen(
                                        data: filteredEvents[index],
                                      ),
                                    ),
                                  );
                                },
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: Icons.bolt,
                                label: 'Update',
                              ),
                            ],
                          ),
                          child: EventListCard(
                            data: filteredEvents[index],
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PosterUserScreen(
                                  data: filteredEvents[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}