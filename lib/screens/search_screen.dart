import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_text_field.dart';
import 'package:event_app/components/home_screen/event_list_card.dart';
import 'package:flutter/material.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Search Results",
        actionIcon: Icons.arrow_back,
        actionOnTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          children: [
            CustomTextField(
              inputController: TextEditingController(),
              prefixIcon: Icons.search,
              borderRadius: 14,
              filledColor: Colors.grey.shade200,
              enabledBorderColor: Colors.grey.shade200,
              borderColor: Colors.grey.shade200,
              focusedBorderColor: Colors.blue,
              autoFocus: true,
            ),
            // Expanded(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     primary: false,
            //     itemCount: 10,
                // itemBuilder: (context, index) => EventListCard(
                //   imagePath: "lib/assets/images/event_image.png",
                //   title: "USA Singing Competition",
                //   location: "Marina Hall, Toronto",
                //   date: "Sun, May 2022, at 11:00 AM",
                //   price: 100,
                
              //     onTap: () {},
              //   ),
              // ),
            // ),
          ],
        ),
      ),
    );
  }
}
