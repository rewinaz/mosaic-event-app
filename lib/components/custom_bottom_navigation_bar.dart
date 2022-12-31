import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
    Color defaultColor = Colors.white;
    return CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: const Color.fromRGBO(249, 249, 255, 1),
        color: const Color.fromRGBO(46, 137, 232, 1),
        index: 1,
        onTap: (value) {},
        items: [
          Icon(Icons.explore, color: defaultColor),
          Icon(Icons.home, color: defaultColor),
          Icon(Icons.add, color: defaultColor),
          Icon(Icons.person, color: defaultColor),
        ]);
  }
}
