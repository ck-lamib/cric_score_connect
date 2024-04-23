import 'package:carousel_slider/carousel_slider.dart';
import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:cric_score_connect/screens/paidHistory/widget/paid_history_team_selector.dart';
import 'package:cric_score_connect/screens/unPaidHistory/controller/un_paid_history_detail_controller.dart';
import 'package:cric_score_connect/screens/unPaidHistory/widget/un_paid_history_team_selector.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnPaidHistoryDetailScreen extends StatelessWidget {
  static const String routeName = "/unpaid-history-detail-screen";
  UnPaidHistoryDetailScreen({super.key});

  final UnPaidHistoryDetailController c =
      Get.find<UnPaidHistoryDetailController>();

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
              title: "Match Details",
              hasNotification: false,
              scrolledUnderElevation: 0,
              floating: false,
              pinned: true,
            )
          ],
          body: Obx(
            () => c.isPageLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ListView(
                      children: [
                        CarouselSlider(
                          items: [
                            Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              color: Colors.green,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
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
                                ],
                              ),
                            ),
                            Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              color: Colors.green,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      child: (c.matchStat.value
                                                  ?.isFirstInning ??
                                              true)
                                          ? Text(
                                              "This is First inning",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles.f14W500(
                                                color: AppColors.primaryColor,
                                              ),
                                            )
                                          : RichText(
                                              text: TextSpan(
                                                text: "First Inning Details: ",
                                                style: CustomTextStyles.f14W500(
                                                  color: AppColors.primaryColor,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${c.matchStat.value?.firstInningTotalRun}-${c.matchStat.value?.firstInningTotalWicket}",
                                                    style: CustomTextStyles
                                                        .f14W500(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "(${c.matchStat.value?.firstInningTotalOver})",
                                                    style: CustomTextStyles
                                                        .f12W400(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )

                                      // Text(
                                      //   "First inning detail: ${c.matchStat.value?.firstInningTotalRun}-${c.matchStat.value?.firstInningTotalWicket} (${c.matchStat.value?.firstInningTotalOver})",
                                      //   textAlign: TextAlign.center,
                                      //   style: CustomTextStyles.f14W500(
                                      //     color: AppColors.primaryColor,
                                      //   ),
                                      // ),
                                      ),
                                ],
                              ),
                            ),
                          ],
                          carouselController: CarouselController(),
                          options: CarouselOptions(
                            // height: 150,
                            aspectRatio: 5,
                            viewportFraction: 0.9,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.2,
                            // viewportFraction: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const UnPaidHistorySelectTeamTabBar(),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
