import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:cric_score_connect/screens/history/views/history_detail_screen.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = "/history-screen";
  const HistoryScreen({super.key});

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
          body: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(HistoryDetailScreen.routeName);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.backGroundColor,
                        child: Text("1"),
                      ),
                      title: Text("Match1"),
                      subtitle: Text("Match between TEam A and TEam B"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
