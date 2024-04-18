import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:cric_score_connect/screens/paidHistory/controller/paid_history_controller.dart';
import 'package:cric_score_connect/screens/paidHistory/controller/paid_history_detail_controller.dart';
import 'package:cric_score_connect/screens/paidHistory/views/paid_history_detail_screen.dart';

import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaidHistoryScreen extends StatelessWidget {
  static const String routeName = "/paid-history-screen";
  PaidHistoryScreen({super.key});
  PaidHistoryScreenController c = Get.find<PaidHistoryScreenController>();

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
              title: "History Screen",
              hasNotification: false,
              scrolledUnderElevation: 0,
              floating: false,
              pinned: true,
            )
          ],
          body: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            child: Obx(
              () => c.isDataLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : c.matchHistoryModelList.isEmpty
                      ? const Center(
                          child: Text(
                            "No match history found. Please check again later.",
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {},
                          child: ListView.builder(
                            itemCount: c.matchHistoryModelList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    PaidHistoryDetailScreen.routeName,
                                    arguments: PaidHistoryDetailArgument(
                                        key: c.matchHistoryModelList[index]
                                            .matchKey!),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 5,
                                  ),
                                  child: Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            AppColors.backGroundColor,
                                        child: Text("$index"),
                                      ),
                                      title: Text(
                                        c.matchHistoryModelList[index]
                                                .matchKey ??
                                            "#123",
                                      ),
                                      subtitle: Text(
                                        "Match between ${c.matchHistoryModelList[index].team1Name} and ${c.matchHistoryModelList[index].team2Name}",
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
