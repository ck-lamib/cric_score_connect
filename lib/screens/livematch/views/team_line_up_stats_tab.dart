import 'package:cric_score_connect/models/gamestats/game_stats.dart';
import 'package:cric_score_connect/screens/gameprofile/views/batting_stats_tabview.dart';
import 'package:cric_score_connect/screens/gameprofile/views/bowling_stats_tabview.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class SelectTeamTabBar extends StatefulWidget {
  const SelectTeamTabBar({
    super.key,
  });

  @override
  State<SelectTeamTabBar> createState() => _SelectTeamTabBarState();
}

class _SelectTeamTabBarState extends State<SelectTeamTabBar>
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
              tabs: const [
                Tab(
                  child: Text(
                    'Home Team',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Tab(
                  child: Text(
                    'Away Team',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: height * 0.8,
          child: TabBarView(
            controller: _tabController,
            children: [
              TeamLineUpStats(),
              TeamLineUpStats(),
            ],
          ),
        )
      ],
    );
  }
}

class TeamLineUpStats extends StatefulWidget {
  const TeamLineUpStats({
    super.key,
  });

  @override
  State<TeamLineUpStats> createState() => _TeamLineUpStatsState();
}

class _TeamLineUpStatsState extends State<TeamLineUpStats>
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
      // height: height * 0.8,
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
            height: height * 0.5,
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
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
                          child: Text(
                            "SR",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "* striker",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "non-strker",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
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
                          child: Text(
                            "W",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "M",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "ER",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "* bowler1",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "bowler2",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "0.00",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f14W500(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
