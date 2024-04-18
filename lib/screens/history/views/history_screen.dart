import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:cric_score_connect/screens/history/controller/history_controller.dart';
import 'package:cric_score_connect/screens/history/views/history_detail_screen.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = "/history-screen";
  HistoryScreen({super.key});
  HistoryScreenController c = Get.find<HistoryScreenController>();

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
          body: Obx(
            () => c.isDataLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : c.liveMatchStatList.isEmpty
                    ? const Center(
                        child: Text(
                          "No match history found. Please check again later.",
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {},
                        child: ListView.builder(
                          itemCount: c.liveMatchStatList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  HistoryDetailScreen.routeName,
                                  arguments: c.liveMatchStatList[index],
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
                                        c.liveMatchStatList[index].matchId ??
                                            "#123"),
                                    subtitle: Text(
                                      "Match between ${c.liveMatchStatList[index].homeTeamName} and ${c.liveMatchStatList[index].awayTeamName}",
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
    );
  }
}
