import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar customAppBar({
  required BuildContext context,
  required String title,
  IconData? leadingIcon,
  Function? leadingOnTap,
  IconData? actionIcon,
  Function? actionOnTap,
}) {
  return AppBar(
    backgroundColor: const Color.fromRGBO(249, 249, 255, 1),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(249, 249, 255, 1),
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0,
    centerTitle: true,
    leading: leadingIcon != null
        ? GestureDetector(
            onTap: () {
              if (leadingOnTap != null) {
                leadingOnTap();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                leadingIcon,
                color: Colors.black,
                size: 30,
              ),
            ),
          )
        : null,
    actions: [
      actionIcon != null
          ? Padding(
              padding: const EdgeInsets.all(17.0),
              child: GestureDetector(
                onTap: () {
                  // TODO Implement onTap
                  if (actionOnTap != null) {
                    actionOnTap();
                  }
                },
                child: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
              ),
            )
          : Container()
    ],
    title: Text(
      title,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 22,
      ),
    ),
  );
}
