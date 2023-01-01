import 'package:event_app/components/custom_bottom_navigation_bar.dart';
import 'package:event_app/screens/add_new_event_screen.dart';
import 'package:event_app/screens/dashboard_screen.dart';
import 'package:event_app/screens/home_screen.dart';
import 'package:event_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    AddNewEventScreen(),
    DashboardScreen(),
    ProfileScreen(),
  ];
  int currentPageIndex = 0;

  onBottomNavChange(selectedPageIndex) {
    setState(() {
      currentPageIndex = selectedPageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CustomBottomAppBar(
        onChange: onBottomNavChange,
      ),
      body: screens[currentPageIndex],
    );
  }
}