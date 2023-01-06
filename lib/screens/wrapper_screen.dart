import 'package:event_app/components/custom_bottom_navigation_bar.dart';
import 'package:event_app/controllers/user_controller.dart';
import 'package:event_app/screens/dashboard_page.dart';
import 'package:event_app/screens/explore_page.dart';
import 'package:event_app/screens/home_page.dart';
import 'package:event_app/screens/profile_page.dart';
import 'package:flutter/material.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  final List<Widget> screens = const [
    HomeScreen(),
    ExploreScreen(),
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
  void initState() {
    UserController.getCurrentUserDetail();
    super.initState();
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
