import 'package:cric_score_connect/screens/gameprofile/controller/game_profile_controller.dart';
import 'package:cric_score_connect/screens/gameprofile/views/batting_bowling_stat_tab.dart';
import 'package:cric_score_connect/screens/gameprofile/widgets/game_profile_app_bar.dart';
import 'package:cric_score_connect/screens/gameprofile/widgets/game_profile_upper_section.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameProfileScreen extends StatefulWidget {
  static const String routeName = "/game-profile-screen";
  const GameProfileScreen({super.key});

  @override
  State<GameProfileScreen> createState() => _GameProfileScreenState();
}

class _GameProfileScreenState extends State<GameProfileScreen>
    with SingleTickerProviderStateMixin {
  final GameProfileController c = Get.find<GameProfileController>();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

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
            GameProfileAppBar(),
            Container(
              margin: const EdgeInsets.only(
                top: kToolbarHeight * 1.18,
              ),
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverList.list(
                    children: [
                      GameProfileUpperSection(
                        tab: Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.backGroundColor,
                                width: 1,
                              ),
                            ),
                            child: TabBar(
                                controller: _tabController,
                                indicatorSize: TabBarIndicatorSize.tab,
                                dividerColor: Colors.transparent,
                                indicator: const BoxDecoration(
                                  color: AppColors.backGroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                labelStyle: CustomTextStyles.f16W600(
                                  color: AppColors.primaryColor,
                                ),
                                unselectedLabelStyle: CustomTextStyles.f16W600(
                                  color: AppColors.textColor,
                                ),
                                labelColor: AppColors.primaryColor,
                                unselectedLabelColor: AppColors.backGroundColor,
                                tabs: const [
                                  Tab(
                                    child: Text(
                                      'Match Stats',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Obx(() => c.gameStats.value != null
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.5,
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      BattingBowlingStatsTab(
                                        batBowlStat: c.gameStats.value!,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.5,
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: AppColors.backGroundColor,
                                            width: 1,
                                          ),
                                        ),
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
