import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/helpers/custom_snack_bar.dart';
import 'package:event_app/helpers/firebase_helpers.dart';
import 'package:event_app/models/event_model.dart';

class EventController {
  static saveEventToFireStore(EventModel eventModel) async {
    List imageUrls = [];
    int i = 0;
    for (var image in eventModel.images) {
      if (image != null) {
        imageUrls.add(await FirebaseHelperFunctions.uploadFileToFireStore(
          File(image!.path),
          "event_pictures",
          image!.name,
        ));
      }
    }

    if (imageUrls.isEmpty) {
      Utils.showErrorSnackBar("An Error Occurred while uploading pictures");
      return;
    }

    CollectionReference eventsCollection =
        FirebaseFirestore.instance.collection("events");

    eventsCollection
        .add({
          "eventName": eventModel.eventName,
          "category": eventModel.category,
          "venueName": eventModel.venueName,
          "venueAddress": eventModel.venueAddress,
          "description": eventModel.description,
          "isActive": eventModel.isActive,
          "isFeatured": eventModel.isFeatured,
          // "isFree": eventModel.isFree,
          "price": eventModel.price,
          "quantity": eventModel.quantity,
          "startDate": eventModel.startDate,
          "endDate": eventModel.endDate,
          "eventImages": imageUrls,
          "postedBy": eventModel.postedBy,
        })
        .then((value) => Utils.showSuccessSnackBar("Event Added Successfully."))
        .catchError(
          (error) => Utils.showErrorSnackBar(
            "There was an error when adding the Event.",
          ),
        );
  }

  static Stream<List<EventModel>> getAllEvents() => FirebaseFirestore.instance
      .collection('events')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => EventModel.fromJson(doc.data(), doc.id))
          .toList());

  static getFeaturedEvents() async {
    CollectionReference eventCollection =
        FirebaseFirestore.instance.collection('events');

    QuerySnapshot querySnapshot = await eventCollection.get();
    List docs = querySnapshot.docs.map((doc) => doc.data()).toList();

    List filteredDocs = [];
    for (var element in docs) {
      if (element["isFeatured"] == true) {
        print(element);
        filteredDocs.add(element);
      }
    }
    return filteredDocs;
  }

  static getEventByCategory({required String category}) async {
    CollectionReference eventCollection =
        FirebaseFirestore.instance.collection('events');

    QuerySnapshot querySnapshot = await eventCollection.get();
    List docs = querySnapshot.docs.map((doc) => doc.data()).toList();

    List filteredDocs = [];
    for (var element in docs) {
      if (element["category"] == category) {
        filteredDocs.add(element);
      }
    }
    return filteredDocs;
  }

  static getEventDetail({required String docId}) async {
    CollectionReference eventCollection =
        FirebaseFirestore.instance.collection('events');
    await eventCollection.doc(docId).get();
  }

  static removeEvent(String docId) {
    final event = FirebaseFirestore.instance.collection('events').doc(docId);
    event.delete();
  }

  static updateEvent(
    EventModel model,
    List oldImages,
    List removedImages,
  ) async {
    // TODO Upload Files
    List imageUrls = oldImages;
    for (var image in model.images) {
      if (image != null) {
        imageUrls.add(await FirebaseHelperFunctions.uploadFileToFireStore(
          File(image!.path),
          "event_pictures",
          image!.name,
        ));
      }
    }

    for (var imgLink in removedImages) {
      if (imgLink != null) {
        FirebaseHelperFunctions.removeImageFromFirestore(imgLink);
      }
    }

    if (imageUrls.isEmpty) {
      Utils.showErrorSnackBar("An Error Occurred while uploading pictures");
      return;
    }

    final event =
        FirebaseFirestore.instance.collection('events').doc(model.docId);

    event.update({
      'eventName': model.eventName,
      'category': model.category,
      'venueName': model.venueName,
      'venueAddress': model.venueAddress,
      'description': model.description,
      'startDate': model.startDate,
      'endDate': model.endDate,
      'isActive': model.isActive,
      'isFeatured': model.isFeatured,
      'eventImages': imageUrls,
      'quantity': model.quantity,
      'price': model.price,
      'postedBy': model.postedBy,
    }).then(
        (value) => Utils.showSuccessSnackBar("Event Updated Successfully."));
  }

  static buyTicket({
    required String userId,
    required EventModel event,
    required int quantitySold,
    Function? followUp,
  }) {
    final salesCollection = FirebaseFirestore.instance.collection('sales').add({
      'eventId': event.docId,
      'price': event.price,
      'quantity': quantitySold,
      'userId': userId,
      'timeStamp': DateTime.now(),
    }).then((value) {
      final eventCollection = FirebaseFirestore.instance
          .collection('events')
          .doc(event.docId)
          .update({
        'quantity': event.quantity - quantitySold,
      }).then(
        (value) {
          Utils.showSuccessSnackBar("Ticket Booked Successfully.");
          followUp != null ? followUp() : null;
        },
      ).catchError(
        (error) => Utils.showErrorSnackBar(
          "There was an error while booking Ticket.",
        ),
      );
    });
  }

  static getAllCategories(Function callBack) async {
    // CollectionReference categoriesCollection =
    //     FirebaseFirestore.instance.collection('categories');

    // QuerySnapshot querySnapshot = await categoriesCollection.get();
    // List docs = querySnapshot.docs.map((doc) => doc.data()).toList();

    // List filteredDocs = [];
    // int i = 0;
    // for (var element in docs) {
    //   filteredDocs.add(element);
    //   categories[i] = element.toString();
    // }
    // return filteredDocs;

    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('categories').get();
    final List<DocumentSnapshot> documents = result.docs;

    List<String> myListString = []; // My list I want to create.

    documents.forEach((snapshot) {
      myListString.add(snapshot.get("categoryName"));
    });

    callBack(myListString);
    return myListString;
  }
}
