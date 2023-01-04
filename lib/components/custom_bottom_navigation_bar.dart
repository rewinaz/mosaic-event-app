import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:event_app/screens/add_new_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:pandabar/fab-button.view.dart';
import 'package:pandabar/pandabar.dart';

class CustomBottomAppBar extends StatelessWidget {
  Function(int selectedPage) onChange;
  CustomBottomAppBar({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return PandaBar(
      onChange: (selectedPage) => {onChange(selectedPage)},
      fabIcon: Icon(Icons.add_outlined),
      onFabButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddNewEventScreen(),
            maintainState: true,
          ),
        );
      },
      buttonData: [
        PandaBarButtonData(
          id: 0,
          icon: Icons.home_filled,
          title: 'Home',
        ),
        PandaBarButtonData(
          id: 1,
          icon: Icons.explore,
          title: 'Explore',
        ),
        PandaBarButtonData(
          id: 2,
          icon: Icons.dashboard_customize,
          title: 'Dashboard',
        ),
        PandaBarButtonData(
          id: 3,
          icon: Icons.account_circle_rounded,
          title: 'Account',
        ),
      ],
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  //   Color defaultColor = Colors.white;
  //   return CurvedNavigationBar(
  //       key: _bottomNavigationKey,
  //       backgroundColor: const Color.fromRGBO(249, 249, 255, 1),
  //       color: const Color.fromRGBO(46, 137, 232, 1),
  //       index: 1,
  //       onTap: (value) {},
  //       items: [
  //         Icon(Icons.explore, color: defaultColor),
  //         Icon(Icons.home, color: defaultColor),
  //         Icon(Icons.add, color: defaultColor),
  //         Icon(Icons.person, color: defaultColor),
  //       ]);
  // }
}
