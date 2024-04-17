import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/screens/game/views/gaming/gaming_screen.dart';
import 'package:cric_score_connect/screens/game/views/team_vs_team_game_screen.dart';
import 'package:cric_score_connect/screens/home/controller/home_controller.dart';
import 'package:cric_score_connect/screens/khalti/khalti_payment_integration.dart';
import 'package:cric_score_connect/screens/livematch/views/live_screen.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/helpers/extensions.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khalti/khalti.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home-screen";
  HomeScreen({super.key});
  final HomeController c = Get.find<HomeController>();
  final CoreController cc = Get.find<CoreController>();

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(
          color: AppColors.backGroundColor,
        ),
      ),
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
                      Obx(
                        () => cc.currentUser.value?.profilePhotoPath != null
                            ? Container(
                                // backgroundColor:
                                //     AppColors.primaryColor,
                                // backgroundImage: const NetworkImage(
                                //     "https://bimalkhatri.com.np/img/hell.png"),
                                // radius: 55,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: 50,
                                width: 50,
                                clipBehavior: Clip.antiAlias,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      cc.currentUser.value!.profilePhotoPath!,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Image.asset(
                                    ImagePath.defaultAvatar,
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    ImagePath.defaultAvatar,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : const CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                backgroundImage: AssetImage(
                                  ImagePath.defaultAvatar,
                                ),
                                radius: 25,
                              ),
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
                              cc.currentUser.value?.name ?? "Bibek Khatri",
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
                    physics: const ClampingScrollPhysics(),
                    children: [
                      CustomElevatedButton(
                        onTap: () {
                          Get.toNamed(TeamVsTeamGameScreen.routeName);
                          // Get.toNamed(GamingScreen.routeName);
                        },
                        title: "Team Vs Team",
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomElevatedButton(
                        onTap: () async {
                          // Get.toNamed(LiveScreen.routeName);

                          bool? paymenResult = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Please enter the match key"),
                                content: const Text(
                                    "Please pay with our payement partner khalti."),
                                actions: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                      ImagePath.khaltiLogo,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back(result: false);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back(result: true);
                                    },
                                    child: const Text("OKay"),
                                  ),
                                ],
                              );
                            },
                          );

                          if (paymenResult != null && paymenResult) {
                            payWithKhaltiInApp(context);
                          }
                        },

                        // {
                        //   TextEditingController textEditingController =
                        //       TextEditingController();
                        //   GlobalKey<FormState> formKey = GlobalKey<FormState>();
                        //   String? matchKey = await showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return Form(
                        //         key: formKey,
                        //         child: AlertDialog(
                        //           title:
                        //               const Text("Please enter the match key"),
                        //           content: CustomTextField(
                        //             controller: textEditingController,
                        //             textInputAction: TextInputAction.done,
                        //             textInputType: TextInputType.text,
                        //             labelText: "Enter match key",
                        //             hint: "#d123",
                        //             validator: Validators.checkFieldEmpty,
                        //           ),
                        //           actions: [
                        //             TextButton(
                        //               onPressed: () {
                        //                 Get.back();
                        //               },
                        //               child: const Text("Cancel"),
                        //             ),
                        //             TextButton(
                        //               onPressed: () {
                        //                 if (formKey.currentState!.validate()) {
                        //                   Get.back(
                        //                       result:
                        //                           textEditingController.text);
                        //                 }
                        //               },
                        //               child: const Text("OKay"),
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   );
                        //   print(matchKey);
                        // },
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

  payWithKhaltiInApp(BuildContext context) {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 1000, //in paisa
        productIdentity: 'liveId',
        productName: 'Live match',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: (paymentSuccessModel) {},
      onFailure: (paymentFailureModel) {
        CustomLogger.trace(paymentFailureModel);
      },
      onCancel: () {},
    );
  }
}
