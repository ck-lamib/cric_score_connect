import 'dart:io';

import 'package:cric_score_connect/screens/dashboard/controller/dashboard_controller.dart';
import 'package:cric_score_connect/screens/profile/controller/profile_controller.dart';
import 'package:cric_score_connect/screens/profile/widgets/profile_app_bar.dart';
import 'package:cric_score_connect/screens/profile/widgets/profile_bottom_section.dart';
import 'package:cric_score_connect/screens/profile/widgets/profile_upper_section.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "/profile-screen";
  ProfileScreen({super.key});
  final ProfileController c = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(
          color: AppColors.backGroundColor,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const ProfileAppBar(),
            Container(
              margin: const EdgeInsets.only(
                top: kToolbarHeight * 1.18,
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  DashboardController dashboardController =
                      Get.find<DashboardController>();
                  dashboardController.getUserSummaryStats();
                  dashboardController.getUserData();
                },
                child: CustomScrollView(
                  physics: ClampingScrollPhysics(),
                  slivers: [
                    SliverList.list(
                      children: [
                        const ProfileUpperSection(),
                        const SizedBox(
                          height: 25,
                        ),
                        ProfileBottomSection(),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
