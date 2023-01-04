import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String eventName, category, venueName, venueAddress, description;
  DateTime startDate, endDate;
  List images = [];
  bool isActive, isFeatured;
  int quantity;
  double price = 0;
  String postedBy;
  String? docId;
  EventModel({
    required this.eventName,
    required this.category,
    required this.venueName,
    required this.venueAddress,
    required this.description,
    required this.isActive,
    required this.isFeatured,
    required this.quantity,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.images,
    required this.postedBy,
    this.docId,
    
  });

  Map<String, dynamic> toJson() => {
        'eventName': eventName,
        'category': category,
        'venueName': venueName,
        'venueAddress': venueAddress,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'isActive': isActive,
        'isFeatured': isFeatured,
        'eventImages': images,
        'quantity': quantity,
        'price': price,
        'postedBy': postedBy,
      };

  static EventModel fromJson(Map<String, dynamic> json, String docId) {
    print("JSON");
    print(json);

    return EventModel(
      eventName: json['eventName'],
      category: json['category'],
      venueName: json['venueName'],
      venueAddress: json['venueAddress'],
      description: json['description'],
      isActive: json['isActive'],
      isFeatured: json['isFeatured'],
      quantity: json['quantity'],
      price: json['price'] + 0.0,
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      images: json['eventImages'] ?? [],
      postedBy: json['postedBy'],
      docId: docId,
    );
  }
}
