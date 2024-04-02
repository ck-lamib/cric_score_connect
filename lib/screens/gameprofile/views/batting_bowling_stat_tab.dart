import 'package:cric_score_connect/models/gamestats/game_stats.dart';
import 'package:cric_score_connect/screens/gameprofile/views/batting_stats_tabview.dart';
import 'package:cric_score_connect/screens/gameprofile/views/bowling_stats_tabview.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class BattingBowlingStatsTab extends StatefulWidget {
  const BattingBowlingStatsTab({
    super.key,
    required this.batBowlStat,
  });

  final BattingBowlingStat batBowlStat;

  @override
  State<BattingBowlingStatsTab> createState() => _BattingBowlingStatsTabState();
}

class _BattingBowlingStatsTabState extends State<BattingBowlingStatsTab>
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
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      height: height * 0.1,
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
        mainAxisAlignment: MainAxisAlignment.center,
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
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: height * 0.3,
            child: TabBarView(
              controller: _tabController,
              children: [
                BattingStatsTabView(
                  battingStats: widget.batBowlStat.batting!,
                ),
                BowlingStatsTabView(
                  bowlingStats: widget.batBowlStat.bowling!,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
