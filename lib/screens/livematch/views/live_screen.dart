import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:cric_score_connect/screens/dashboard/views/dashboard_screen.dart';
import 'package:cric_score_connect/screens/game/controller/team_vs_team_game_controller.dart';
import 'package:cric_score_connect/screens/game/views/gaming/gaming_screen.dart';
import 'package:cric_score_connect/screens/game/widgets/gaming/gaming_app_bar.dart';
import 'package:cric_score_connect/screens/livematch/controller/live_screen_controller.dart';
import 'package:cric_score_connect/screens/livematch/views/team_line_up_stats_tab.dart';
import 'package:cric_score_connect/screens/match/delivery.dart';
import 'package:cric_score_connect/screens/match/enums/extra.dart';
import 'package:cric_score_connect/screens/match/overs.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LiveScreen extends StatelessWidget {
  static const String routeName = "/live-screen";
  LiveScreen({super.key});
  final LiveScreenController c = Get.find<LiveScreenController>();

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
              title: "homeTeamController Vs awayTeamController",
              hasNotification: false,
              scrolledUnderElevation: 0,
              floating: false,
              pinned: true,
            ),
          ],
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    child: Text(
                      "batting team is Batting against bowlingTeam",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.f14W500(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),

                //  Text(
                //           "bowling team needs 18 runs from 20 balls to win against batting team.",
                //           textAlign: TextAlign.center,
                //           style: CustomTextStyles.f14W500(
                //             color: AppColors.primaryColor,
                //           ),
                //         )

                SizeConfig.getSpace(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "11-1",
                        style: CustomTextStyles.f32W600(
                          color: AppColors.backGroundColor,
                        ),
                        children: [
                          TextSpan(
                            text: "(2.0)",
                            style: CustomTextStyles.f18W600(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ],
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
                          "#321F",
                          style: CustomTextStyles.f14W500(
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const InkWell(
                          splashFactory: InkRipple.splashFactory,
                          child: Icon(
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
                      GamingRatingStat(title: "Target", stat: "--:--"),
                      GamingRatingStat(title: "C.R.R", stat: "0.00"),
                      GamingRatingStat(
                        title: "R.R.R",
                        stat: "--:--",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "* striker",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: Colors.green,
                              ),
                            ),
                            // child:
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
                      SizeConfig.getSpace(height: 5),
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
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "bowler",
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
                ),
                SizeConfig.getSpace(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
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
                          "This Over:",
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.f14W500(),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: 70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: "" != ""
                                            ? AppColors.errorColor
                                            : AppColors.primaryColor,
                                        shape: BoxShape.circle,
                                        // borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: "" != ""
                                              ? AppColors.errorColor
                                              : AppColors.hintTextColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        "" != "" ? "" : "",
                                        style: CustomTextStyles.f10W400(
                                          color: "" != ""
                                              ? AppColors.primaryColor
                                              : AppColors.hintTextColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "" != ""
                                          ? "" == ""
                                              ? ""
                                              : ""
                                          : "",
                                      style: CustomTextStyles.f12W400(
                                        color: AppColors.hintTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
                              child: Text(
                                "0 B",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "0 LB",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "0 WD",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "0 NB",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "0 P",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
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
                TeamLineUpStats(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
