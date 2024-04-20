import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:cric_score_connect/models/overs.dart';
import 'package:cric_score_connect/screens/game/views/gaming/gaming_screen.dart';
import 'package:cric_score_connect/screens/livematch/controller/live_screen_controller.dart';
import 'package:cric_score_connect/screens/livematch/views/team_line_up_stats_tab.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LiveScreen extends StatefulWidget {
  static const String routeName = "/live-screen";
  LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  final LiveScreenController c = Get.find<LiveScreenController>();

  @override
  void dispose() {
    try {
      c.stopFetching();
    } catch (e) {
      CustomLogger.trace(e);
    }
    CustomLogger.trace("Disposed called");
    super.dispose();
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
        child: Obx(
          () => c.isPageLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    const CommonSilverAppBar(
                      hasLeading: true,
                      title: "Live match",
                      hasNotification: false,
                      scrolledUnderElevation: 0,
                      floating: false,
                      pinned: true,
                    ),
                  ],
                  body: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: ListView(
                      shrinkWrap: true,
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
                            child: Obx(
                              () => Text(
                                c.liveMatchStat.value?.finishedMessage ?? "",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizeConfig.getSpace(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => RichText(
                                text: TextSpan(
                                  text:
                                      "${(c.liveMatchStat.value?.isFirstInning ?? false) ? c.liveMatchStat.value?.firstInningTotalRun : c.liveMatchStat.value?.secondInningTotalRun}-${(c.liveMatchStat.value?.isFirstInning ?? false) ? c.liveMatchStat.value?.firstInningTotalWicket : c.liveMatchStat.value?.secondInningTotalWicket}",
                                  style: CustomTextStyles.f32W600(
                                    color: AppColors.backGroundColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "(${(c.liveMatchStat.value?.isFirstInning ?? false) ? c.liveMatchStat.value?.firstInningTotalOver : c.liveMatchStat.value?.secondInningTotalOver})",
                                      style: CustomTextStyles.f18W600(
                                        color: AppColors.hintTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Match Code: ",
                                  style: CustomTextStyles.f14W500(
                                    color: AppColors.hintTextColor,
                                  ),
                                ),
                                Text(
                                  c.matchKey,
                                  style: CustomTextStyles.f14W500(
                                    color: AppColors.hintTextColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  splashFactory: InkRipple.splashFactory,
                                  onTap: () {
                                    Clipboard.setData(
                                            ClipboardData(text: c.matchKey))
                                        .then(
                                      (value) => CustomSnackBar.info(
                                          message:
                                              "Successfully copied ${c.matchKey} to clipboard."),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.copy_rounded,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizeConfig.getSpace(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.backGroundColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Obx(
                                () => GamingRatingStat(
                                    title: "Target",
                                    stat: c.liveMatchStat.value?.target ??
                                        "--:--"),
                              ),
                              Tooltip(
                                message: "Current run rate",
                                child: Obx(
                                  () => GamingRatingStat(
                                      title: "C.R.R",
                                      stat:
                                          c.liveMatchStat.value?.crr ?? "0.00"),
                                ),
                              ),
                              Tooltip(
                                message: "Required run rate",
                                child: Obx(
                                  () => GamingRatingStat(
                                    title: "R.R.R",
                                    stat: c.liveMatchStat.value?.rrr ?? "--:--",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizeConfig.getSpace(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 5,
                          ),
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
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,

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
                              Obx(
                                () => c.striker.value == null
                                    ? const SizedBox.shrink()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "* ${c.striker.value!.name}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: CustomTextStyles.f14W500(
                                                color: Colors.green,
                                              ),
                                            ),
                                            // child:
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.striker.value!.matchBattingStat?.runs}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.striker.value!.matchBattingStat?.balls}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.striker.value!.matchBattingStat?.fours}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.striker.value!.matchBattingStat?.sixes}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Obx(
                                              () {
                                                int? strikerRuns = c
                                                        .striker
                                                        .value!
                                                        .matchBattingStat
                                                        ?.runs ??
                                                    0;
                                                int strikerBalls = c
                                                        .striker
                                                        .value
                                                        ?.matchBattingStat
                                                        ?.balls ??
                                                    0;

                                                return Text(
                                                  strikerBalls == 0 &&
                                                          strikerRuns == 0
                                                      ? "0.0"
                                                      : ((strikerRuns /
                                                                  strikerBalls) *
                                                              100)
                                                          .toStringAsFixed(0),
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      CustomTextStyles.f14W500(
                                                    color:
                                                        AppColors.hintTextColor,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              SizeConfig.getSpace(height: 5),
                              Obx(
                                () => c.nonStriker.value == null
                                    ? const SizedBox.shrink()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "${c.nonStriker.value!.name}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: CustomTextStyles.f14W500(
                                                color: Colors.green,
                                              ),
                                            ),
                                            // child:
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.nonStriker.value!.matchBattingStat?.runs}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.nonStriker.value!.matchBattingStat?.balls}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.nonStriker.value!.matchBattingStat?.fours}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.nonStriker.value!.matchBattingStat?.sixes}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Obx(
                                              () {
                                                int? nonStrikerRuns = c
                                                        .nonStriker
                                                        .value!
                                                        .matchBattingStat
                                                        ?.runs ??
                                                    0;
                                                int nonStrikerBalls = c
                                                        .nonStriker
                                                        .value
                                                        ?.matchBattingStat
                                                        ?.balls ??
                                                    0;

                                                return Text(
                                                  nonStrikerBalls == 0 &&
                                                          nonStrikerRuns == 0
                                                      ? "0.0"
                                                      : ((nonStrikerRuns /
                                                                  nonStrikerBalls) *
                                                              100)
                                                          .toStringAsFixed(0),
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      CustomTextStyles.f14W500(
                                                    color:
                                                        AppColors.hintTextColor,
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizeConfig.getSpace(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 5,
                          ),
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
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,

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
                                      message: "Wicket",
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
                                      message: "Maiden",
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
                              Obx(
                                () => c.bowler.value == null
                                    ? const SizedBox.shrink()
                                    : Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "${c.bowler.value?.name}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: CustomTextStyles.f14W500(),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.bowler.value?.matchBowlingStat?.overs}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.bowler.value?.matchBowlingStat?.runs}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.bowler.value?.matchBowlingStat?.wickets}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${c.bowler.value?.matchBowlingStat?.maidens}",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Obx(
                                              () {
                                                double? totalRunsConceded = (c
                                                            .bowler
                                                            .value
                                                            ?.matchBowlingStat
                                                            ?.runs ??
                                                        0.0)
                                                    .toDouble();
                                                double totalOversBowled =
                                                    double.parse(
                                                  Over.overs(c
                                                          .bowler
                                                          .value
                                                          ?.matchBowlingStat
                                                          ?.balls ??
                                                      0),
                                                );

                                                return Text(
                                                  totalRunsConceded == 0 &&
                                                          totalOversBowled == 0
                                                      ? "0.0"
                                                      : ((totalRunsConceded /
                                                                  totalOversBowled))
                                                              .isFinite
                                                          ? ((totalRunsConceded /
                                                                  totalOversBowled))
                                                              .toStringAsFixed(
                                                                  0)
                                                          : "0",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      CustomTextStyles.f14W500(
                                                    color:
                                                        AppColors.hintTextColor,
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizeConfig.getSpace(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.backGroundColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Extras:",
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.f14W500(),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Tooltip(
                                        message: "Byes",
                                        child: Obx(
                                          () => Text(
                                            "${c.liveMatchStat.value?.extras?.byes} B",
                                            textAlign: TextAlign.center,
                                            style: CustomTextStyles.f14W500(
                                              color: AppColors.hintTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Tooltip(
                                        message: "Let Byes",
                                        child: Obx(
                                          () => Text(
                                            "${c.liveMatchStat.value?.extras?.legByes} LB",
                                            textAlign: TextAlign.center,
                                            style: CustomTextStyles.f14W500(
                                              color: AppColors.hintTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Tooltip(
                                        message: "Wides",
                                        child: Obx(
                                          () => Text(
                                            "${c.liveMatchStat.value?.extras?.wide} WD",
                                            textAlign: TextAlign.center,
                                            style: CustomTextStyles.f14W500(
                                              color: AppColors.hintTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Tooltip(
                                        message: "No Balls",
                                        child: Obx(
                                          () => Text(
                                            "${c.liveMatchStat.value?.extras?.noBall} NB",
                                            textAlign: TextAlign.center,
                                            style: CustomTextStyles.f14W500(
                                              color: AppColors.hintTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Tooltip(
                                        message: "Penalties",
                                        child: Obx(
                                          () => Text(
                                            "${c.liveMatchStat.value?.extras?.penalty} P",
                                            textAlign: TextAlign.center,
                                            style: CustomTextStyles.f14W500(
                                              color: AppColors.hintTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizeConfig.getSpace(),
                        const SelectTeamTabBar(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
