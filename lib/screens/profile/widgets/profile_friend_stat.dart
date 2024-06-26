import 'package:cric_score_connect/screens/dashboard/controller/dashboard_controller.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileFrientStats extends StatelessWidget {
  ProfileFrientStats({
    super.key,
  });
  DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.backGroundColor,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => ProfileFrientStatsTile(
              data: "${dashboardController.totalFriend.value}",
              title: "Total Friends",
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Obx(
            () => ProfileFrientStatsTile(
              data: "${dashboardController.totalMatchPlayed.value}",
              title: "Match Played",
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileFrientStatsTile extends StatelessWidget {
  const ProfileFrientStatsTile({
    super.key,
    this.data,
    required this.title,
  });
  final String? data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data ?? "--:--",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: CustomTextStyles.f16W600(),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W500(),
          ),
        ],
      ),
    );
  }
}
