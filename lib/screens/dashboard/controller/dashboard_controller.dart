import 'package:cric_score_connect/screens/home/views/home_screen.dart';
import 'package:cric_score_connect/screens/player/views/player_screen.dart';
import 'package:cric_score_connect/screens/profile/views/profile_screen.dart';
import 'package:cric_score_connect/screens/search/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  PageController pageController = PageController();
  var pageViewItems = [
    HomeScreen(),
    const SearchScreen(),
    const PlayerScreen(),
    ProfileScreen(),
  ];

  final _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;
  changeIndex(int value) {
    _currentIndex.value = value;
  }
}
