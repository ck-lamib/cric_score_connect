import 'package:cric_score_connect/screens/dashboard/controller/dashboard_controller.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = "/dashboard-screen";
  DashboardScreen({super.key});
  final DashboardController c = Get.find<DashboardController>();
  final List<NavigationDestination> navBar = [
    const NavigationDestination(
      icon: Icon(Icons.sports_cricket_outlined),
      selectedIcon: Icon(Icons.sports_cricket_outlined),
      label: "Home",
      tooltip: "Home",
    ),
    const NavigationDestination(
      icon: Icon(Icons.search_outlined),
      selectedIcon: Icon(Icons.search_outlined),
      label: "Search",
    ),
    const NavigationDestination(
      icon: Icon(Icons.group_outlined),
      selectedIcon: Icon(Icons.group_outlined),
      label: "Players",
    ),
    const NavigationDestination(
      icon: Icon(Icons.account_box_outlined),
      selectedIcon: Icon(Icons.account_box_outlined),
      label: "Profile",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          animationDuration: const Duration(seconds: 2),
          destinations: navBar,
          selectedIndex: c.currentIndex,
          onDestinationSelected: (value) {
            c.changeIndex(value);
            c.pageController.jumpToPage(value);
          },
        ),
      ),
      body: PageView(
        controller: c.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          c.changeIndex(value);
        },
        children: c.pageViewItems,
      ),
    );
  }
}
