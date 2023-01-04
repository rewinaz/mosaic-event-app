import 'package:event_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeaturedEventCard extends StatelessWidget {
  EventModel data;
  Function onTap;
  FeaturedEventCard({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = 350.0;
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: cardWidth,
              color: Colors.white,
              child: Column(
                children: [
                  // Image
                  SizedBox(
                    height: 200,
                    width: cardWidth,
                    child: Image.network(
                      data.images.first,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Event Information
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and Location
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.eventName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data.category,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        // Date
                        Text(
                          DateFormat("E, d MMM yyy AT HH:MM")
                              .format(data.startDate),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
