import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Color defaultColor = Colors.white;
    return CurvedNavigationBar(
        backgroundColor: const Color.fromRGBO(249, 249, 255, 1),
        color: const Color.fromRGBO(46, 137, 232, 1),
        onTap: (value) => {print(value)},
        items: [
          Icon(Icons.explore, color: defaultColor),
          Icon(Icons.home, color: defaultColor),
          Icon(Icons.add, color: defaultColor),
          Icon(Icons.person, color: defaultColor),
        ]);
  }
}
