import 'package:cric_score_connect/screens/home/controller/home_controller.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/helpers/extensions.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home-screen";
  HomeScreen({super.key});
  final HomeController c = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: AppColors.backGroundColor,
              scrolledUnderElevation: 0,
              floating: false,
              pinned: true,
              collapsedHeight: kToolbarHeight * 1.6,
              toolbarHeight: kToolbarHeight * 1.6,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              title: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                margin: EdgeInsets.zero,
                child: SizedBox(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 25,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(
                                  "Hi!, ${c.currentTime.value.getGreeting()}",
                                  style: CustomTextStyles.f18W600(
                                    color: AppColors.primaryColor,
                                  ),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Bibek Khatri",
                              style: CustomTextStyles.f14W400(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(360),
                          onTap: () {},
                          child: const Center(
                            child: Icon(
                              Icons.notifications_active,
                              color: AppColors.backGroundColor,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      CustomElevatedButton(
                        onTap: () {},
                        title: "Team Vs Team",
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      CustomElevatedButton(
                        onTap: () {},
                        title: "Individual",
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      CustomElevatedButton(
                        onTap: () {},
                        title: "Join Live Match",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
