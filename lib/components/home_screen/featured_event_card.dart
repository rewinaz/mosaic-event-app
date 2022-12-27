import 'package:flutter/material.dart';

class FeaturedEventCard extends StatelessWidget {
  String imagePath, eventTitle, eventDescription, eventDate;
  FeaturedEventCard({
    Key? key,
    required this.imagePath,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    double cardWidth = 350.0;
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
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
                child: Image.asset(
                  imagePath,
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
                          eventTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          eventDescription,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    // Date
                    Text(
                      eventDate,
                      textAlign: TextAlign.right,
                    )
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
