import 'package:cached_network_image/cached_network_image.dart';
import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/screens/gameprofile/controller/game_profile_controller.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameProfileUserDetailCard extends StatelessWidget {
  GameProfileUserDetailCard({
    super.key,
  });

  final GameProfileController c = Get.find<GameProfileController>();
  final CoreController cc = Get.find<CoreController>();

  @override
  Widget build(BuildContext context) {
    CustomLogger.trace(c.showAddFriend.value);
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              // width: double.infinity,
              // margin: EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: c.gameStats.value?.user?.profilePhotoPath != null
                  ? Container(
                      // backgroundColor:
                      //     AppColors.primaryColor,
                      // backgroundImage: const NetworkImage(
                      //     "https://bimalkhatri.com.np/img/hell.png"),
                      // radius: 55,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      height: 120,
                      width: 120,
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        imageUrl: c.gameStats.value!.user!.profilePhotoPath!,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Image.asset(
                          ImagePath.defaultAvatar,
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          ImagePath.defaultAvatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const CircleAvatar(
                      backgroundColor: AppColors.onBackGroundColor,
                      backgroundImage: AssetImage(
                        ImagePath.defaultAvatar,
                      ),
                      radius: 55,
                    ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.onBackGroundColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primaryColor,
                  ),
                ),
                child: Text(
                  "@${c.gameStats.value?.user?.username}",
                  style: CustomTextStyles.f12W400(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "${c.gameStats.value?.user?.name}",
          style: CustomTextStyles.f18W600(
            color: AppColors.primaryColor,
          ),
        ),
        Text(
          "${c.gameStats.value?.user?.email}",
          style: CustomTextStyles.f16W300(
            color: AppColors.primaryColor,
          ),
        ),
        Obx(
          () => c.showAddFriend.value
              ? (cc.currentUser.value?.id != c.gameStats.value?.user?.id)
                  ? Column(
                      children: [
                        SizeConfig.getSpace(),
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: Obx(() => c.isAddFriendSuccess.value
                              ? CustomElevatedButton(
                                  title: "Request Sent",
                                  backGroundColor: Colors.blue.withOpacity(0.5),
                                  onTap: () {},
                                )
                              : CustomElevatedButton(
                                  title: "Add Friend",
                                  backGroundColor: Colors.blue,
                                  onTap: () async {
                                    await c.addFriend(c.gameStats.value!.user!);
                                  },
                                )),
                        ),
                        SizeConfig.getSpace(),
                      ],
                    )
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
