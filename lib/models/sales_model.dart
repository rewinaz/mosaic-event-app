import 'package:cloud_firestore/cloud_firestore.dart';

class SalesModel {
  String docId, eventId, userId, sellerId;
  double price;
  int quantity;

  SalesModel({
    required this.docId,
    required this.eventId,
    required this.sellerId,
    required this.userId,
    required this.quantity,
    required this.price,
  });

  // static Stream<List<EventModel>> getAllEvents() => FirebaseFirestore.instance
  //     .collection('events')
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs
  //         .map((doc) => EventModel.fromJson(doc.data(), doc.id))
  //         .toList());

  static Stream<List<SalesModel>> getAllSales() => FirebaseFirestore.instance
      .collection('sales')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => SalesModel.fromJson(doc.data(), doc.id))
          .toList());

  static SalesModel fromJson(Map<String, dynamic> json, String docId) {
    return SalesModel(
      docId: docId,
      eventId: json['eventId'],
      userId: json['userId'],
      sellerId: json['sellerId'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  static double calculateTotalSale(List<SalesModel> sales) {
    double total = 0;

    for (var element in sales) {
      total += (element.price * element.quantity);
    }

    return total;
  }

  static int calculateTicketsSold(List<SalesModel> sales) {
    int total = 0;

    for (var element in sales) {
      total += element.quantity;
    }

    return total;
  }
}
