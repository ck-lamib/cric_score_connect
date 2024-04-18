import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:cric_score_connect/screens/history/controller/history_detail_controller.dart';
import 'package:cric_score_connect/screens/history/widget/history_team_selector.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryDetailScreen extends StatelessWidget {
  static const String routeName = "/history-detail-screen";
  HistoryDetailScreen({super.key});

  final HistoryDetailController c = Get.find<HistoryDetailController>();

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
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const CommonSilverAppBar(
              hasLeading: true,
              title: "History Detail Screen",
              hasNotification: false,
              scrolledUnderElevation: 0,
              floating: false,
              pinned: true,
            )
          ],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  color: Colors.green,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Text(
                      c.matchStat.value?.finishedMessage ?? "",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.f14W500(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const HistorySelectTeamTabBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
