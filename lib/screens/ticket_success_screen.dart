import 'dart:io';

import 'package:event_app/components/custom_app_bar.dart';
import 'package:event_app/components/custom_button_rounded.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/screens/wrapper_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class TicketSuccessScreen extends StatelessWidget {
  List<Widget> tickets;
  EventModel event;
  String userId;
  int quantity;
  TicketSuccessScreen({
    super.key,
    required this.tickets,
    required this.event,
    required this.userId,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final _controller = ScreenshotController();

    Widget _buildImage(Widget el) {
      return Container(
        color: Colors.white,
        child: el,
      );
    }

    _requestPermission() async {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();

      final info = statuses[Permission.storage].toString();
      print(info);
    }

    saveImage(Uint8List byteData) async {
      _requestPermission();
      final time = DateTime.now()
          .toIso8601String()
          .replaceAll(".", "_")
          .replaceAll(":", "_");

      final name = "${event.eventName}_$time";
      final result = await ImageGallerySaver.saveImage(byteData, name: name);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WrapperScreen(),
        ),
      );
      return result['filePath'];
    }

    saveAndShare(Uint8List bytes) async {
      _requestPermission();
      final directory = await getApplicationDocumentsDirectory();
      final image = await File('${directory.path}/mosaic.png').create();
      await image.writeAsBytes(bytes);
      await Share.shareFiles([image.path],
              subject: "Your Ticket to ${event.eventName}")
          .then((value) {});
    }

    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: "Booked Tickets",
          leadingIcon: Icons.home,
          leadingOnTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WrapperScreen(),
              ),
            );
          }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var element in tickets)
                  Column(
                    children: [
                      Screenshot(
                        controller: _controller,
                        child: element,
                      ),
                      Row(
                        children: [
                          CustomButtonRounded(
                            buttonText: "Download Image",
                            buttonOnClick: () async {
                              var image;
                              await _controller
                                  .captureFromWidget(
                                    _buildImage(
                                      MediaQuery(
                                        data: MediaQueryData(),
                                        child: element,
                                      ),
                                    ),
                                  )
                                  .then((value) => image = value);

                              if (image == null) return;

                              print(image);
                              await saveImage(image);
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomButtonRounded(
                            buttonText: "Share Ticket",
                            buttonOnClick: () async {
                              var image;
                              await _controller
                                  .captureFromWidget(
                                    _buildImage(
                                      MediaQuery(
                                        data: MediaQueryData(),
                                        child: element,
                                      ),
                                    ),
                                  )
                                  .then((value) => image = value);

                              if (image == null) return;
                              print("SHARE");
                              saveAndShare(image);
                            },
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
