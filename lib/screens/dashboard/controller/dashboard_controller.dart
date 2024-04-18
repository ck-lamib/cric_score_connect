import 'dart:convert';

import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/userstats/userstat.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/friend/views/friend_screen.dart';
import 'package:cric_score_connect/screens/home/views/home_screen.dart';
import 'package:cric_score_connect/screens/profile/views/profile_screen.dart';
import 'package:cric_score_connect/screens/search/views/search_screen.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/helpers/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    getUserSummaryStats();
    super.onInit();
  }

  PageController pageController = PageController();
  var pageViewItems = [
    HomeScreen(),
    SearchScreen(),
    const FriendScreen(),
    ProfileScreen(),
  ];

  final _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;
  changeIndex(int value) {
    _currentIndex.value = value;
  }

  RxInt totalFriend = RxInt(0);
  RxInt totalMatchPlayed = RxInt(0);

  getUserSummaryStats() {
    CoreController cc = Get.find<CoreController>();
    UserStatsRepo.getUserSummaryStat(
      userId: cc.currentUser.value!.id!,
      onSuccess: (totalFriendd, totalMatchPlayedd) {
        totalFriend.value = totalFriendd;
        totalMatchPlayed.value = totalMatchPlayedd;
      },
      onError: (message) {
        CustomLogger.trace(message);
      },
    );
  }

  getUserData() async {
    CoreController cc = Get.find<CoreController>();
    await UserStatsRepo.getUserStat(
      userId: cc.currentUser.value!.id!,
      onSuccess: (gameStas) async {
        User? gameUser = cc.currentUser.value?.copyWith(
          id: gameStas.user?.id,
          name: gameStas.user?.name,
          username: gameStas.user?.username,
          address: gameStas.user?.address,
          dob: gameStas.user?.dob,
          email: gameStas.user?.email,
          phone: gameStas.user?.phone,
          playerType: gameStas.user?.playerType,
          profilePhotoPath: gameStas.user?.profilePhotoPath,
        );
        final box = GetStorage();
        await box.write(StorageKeys.USER, jsonEncode(gameUser?.toJson()));
        cc.loadCurrentUser();
      },
      onError: (message) {},
    );
  }
}
