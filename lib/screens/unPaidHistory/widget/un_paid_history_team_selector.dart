import 'package:cric_score_connect/models/gamestats/live_match_model.dart';
import 'package:cric_score_connect/models/overs.dart';
import 'package:cric_score_connect/screens/unPaidHistory/controller/un_paid_history_detail_controller.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnPaidHistorySelectTeamTabBar extends StatefulWidget {
  const UnPaidHistorySelectTeamTabBar({
    super.key,
  });

  @override
  State<UnPaidHistorySelectTeamTabBar> createState() =>
      _UnPaidHistorySelectTeamTabBarState();
}

class _UnPaidHistorySelectTeamTabBarState
    extends State<UnPaidHistorySelectTeamTabBar>
    with SingleTickerProviderStateMixin {
  UnPaidHistoryDetailController c = Get.find<UnPaidHistoryDetailController>();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        Container(
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
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              labelStyle: CustomTextStyles.f16W600(
                color: AppColors.primaryColor,
              ),
              unselectedLabelStyle: CustomTextStyles.f16W600(
                color: AppColors.textColor,
              ),
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: AppColors.backGroundColor,
              tabs: [
                Tab(
                  child: Text(
                    '${c.matchStat.value?.homeTeamName}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Tab(
                  child: Text(
                    '${c.matchStat.value?.awayTeamName}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: height * 0.49,
          child: TabBarView(
            controller: _tabController,
            children: [
              Obx(
                () => UnPaidHistoryTeamLineUpStats(
                  gameTeam: c.matchStat.value!.homeTeam!,
                ),
              ),
              Obx(
                () => UnPaidHistoryTeamLineUpStats(
                  gameTeam: c.matchStat.value!.awayTeam!,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class UnPaidHistoryTeamLineUpStats extends StatefulWidget {
  const UnPaidHistoryTeamLineUpStats({
    super.key,
    required this.gameTeam,
  });

  final List<LiveTeam> gameTeam;
  @override
  State<UnPaidHistoryTeamLineUpStats> createState() =>
      _UnPaidHistoryTeamLineUpStatsState();
}

class _UnPaidHistoryTeamLineUpStatsState
    extends State<UnPaidHistoryTeamLineUpStats>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      // height: height * 0.4,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.backGroundColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12 * 4,
            ),
            padding: const EdgeInsets.all(0),
            height: height * 0.05,
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
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              labelStyle: CustomTextStyles.f14W500(
                color: AppColors.primaryColor,
              ),
              unselectedLabelStyle: CustomTextStyles.f14W500(
                color: AppColors.textColor,
              ),
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: AppColors.backGroundColor,
              tabs: const [
                Tab(
                  child: Text(
                    'Batting',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Tab(
                  child: Text(
                    'Bowling',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: height * 0.38,
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Batsman",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Runs",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Ball",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "4s",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "6s",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Tooltip(
                              message: "Strike Rate",
                              child: Text(
                                "SR",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.gameTeam.length,
                        itemBuilder: (context, index) {
                          return UnPaidHistoryBatterTile(
                            batter: widget.gameTeam[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Bowler",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Overs",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Run",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Tooltip(
                              message: "Wickets",
                              child: Text(
                                "Wk",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Tooltip(
                              message: "Maidens",
                              child: Text(
                                "M",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Tooltip(
                              message: "Economy Rate",
                              child: Text(
                                "ER",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.gameTeam.length,
                        itemBuilder: (context, index) {
                          return UnPaidHistoryBowlerTile(
                            bowler: widget.gameTeam[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UnPaidHistoryBowlerTile extends StatelessWidget {
  const UnPaidHistoryBowlerTile({
    super.key,
    required this.bowler,
  });
  final LiveTeam bowler;

  @override
  Widget build(BuildContext context) {
    double? totalRunsConceded =
        (bowler.matchBowlingStat?.runs ?? 0.0).toDouble();
    double totalOversBowled = double.parse(
      Over.overs(bowler.matchBowlingStat?.balls ?? 0),
    );
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "${bowler.name}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: CustomTextStyles.f14W500(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${bowler.matchBowlingStat?.overs}",
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W500(
              color: AppColors.hintTextColor,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${bowler.matchBowlingStat?.runs}",
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W500(
              color: AppColors.hintTextColor,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${bowler.matchBowlingStat?.wickets}",
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W500(
              color: AppColors.hintTextColor,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${bowler.matchBowlingStat?.maidens}",
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W500(
              color: AppColors.hintTextColor,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            totalRunsConceded == 0 && totalOversBowled == 0
                ? "0.0"
                : ((totalRunsConceded / totalOversBowled)).isFinite
                    ? ((totalRunsConceded / totalOversBowled))
                        .toStringAsFixed(0)
                    : "0",
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W500(
              color: AppColors.hintTextColor,
            ),
          ),
        ),
      ],
    );
  }
}

class UnPaidHistoryBatterTile extends StatelessWidget {
  const UnPaidHistoryBatterTile({
    super.key,
    required this.batter,
  });
  final LiveTeam batter;

  @override
  Widget build(BuildContext context) {
    int? strikerRuns = batter.matchBattingStat?.runs ?? 0;
    int strikerBalls = batter.matchBattingStat?.balls ?? 0;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "${batter.name}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: CustomTextStyles.f14W500(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${batter.matchBattingStat?.runs}",
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W500(
              color: AppColors.hintTextColor,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${batter.matchBattingStat?.balls}",
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W500(
              color: AppColors.hintTextColor,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${batter.matchBattingStat?.fours}",
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W500(
              color: AppColors.hintTextColor,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${batter.matchBattingStat?.sixes}",
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W500(
              color: AppColors.hintTextColor,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            strikerBalls == 0 && strikerRuns == 0
                ? "0.0"
                : ((strikerRuns / strikerBalls) * 100).toStringAsFixed(0),
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W500(
              color: AppColors.hintTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
