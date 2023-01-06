import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_button_rounded.dart';
import 'package:event_app/controllers/event_controller.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/screens/ticket_success_screen.dart';
import 'package:event_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  EventModel data;
  CheckoutScreen({
    super.key,
    required this.data,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  checkoutOnTap(EventModel event, int quantity) {
    // TODO: IMPLEMENT UPDATE THEN UPDATE QUANTITY
  }

  int quantity = 1;

  List<Widget> tickets = [];

  getTickets({
    required int quantity,
    required EventModel event,
    required String userId,
  }) {
    for (var i = 0; i < this.quantity; i++) {
      tickets.add(
        QrImage(
            data: "${event.docId}.${userId}.${event.quantity - i}",
            version: QrVersions.auto,
            size: 320,
            gapless: false,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: const Size(80, 80),
            )),
      );
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TicketSuccessScreen(
                  tickets: tickets,
                  event: event,
                  userId: userId,
                  quantity: this.quantity,
                )));
  }

  @override
  void initState() {
    quantity = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Checkout",
        leadingIcon: Icons.arrow_back_ios,
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price : ",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    "${widget.data.price} BR",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade400,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quantity : ",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          if (quantity > 1) {
                            quantity = quantity - 1;
                          }
                        }),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: 30,
                            height: 30,
                            color: Colors.blueGrey,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          quantity.toString(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade400,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          if (quantity < widget.data.quantity) {
                            quantity = quantity + 1;
                          }
                        }),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: 30,
                            height: 30,
                            color: Colors.blueGrey,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),

              // DIVIDER
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Price : ",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "${widget.data.price * quantity} BR",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade400,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              // Checkout Button
              CustomButtonRounded(
                buttonText: "Checkout",
                buttonOnClick: () {
                  EventController.buyTicket(
                      userId: currentUser.docId,
                      event: widget.data,
                      quantitySold: quantity,
                      followUp: getTickets(
                        quantity: quantity,
                        event: widget.data,
                        userId: currentUser.docId,
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
