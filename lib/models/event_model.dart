import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String eventName, category, venueName, venueAddress, description;
  DateTime startDate, endDate;
  List images = [];
  bool isActive, isFeatured, isFree;
  int quantity;
  double price = 0;
  DocumentReference postedBy;
  EventModel({
    required this.eventName,
    required this.category,
    required this.venueName,
    required this.venueAddress,
    required this.description,
    required this.isActive,
    required this.isFeatured,
    required this.isFree,
    required this.quantity,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.images,
    required this.postedBy,
  });

  getStartTime() {}
  getEndTime() {}
  getStartDate() {}
  getEndDate() {}
}
