import 'package:cached_network_image/cached_network_image.dart';
import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUserDetailCard extends StatelessWidget {
  ProfileUserDetailCard({
    super.key,
  });

  final CoreController cc = Get.find<CoreController>();

  @override
  Widget build(BuildContext context) {
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
              child: Obx(
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
                        height: 110,
                        width: 110,
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: cc.currentUser.value!.profilePhotoPath!,
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
                  "@${cc.currentUser.value?.username}",
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
          "${cc.currentUser.value?.name}",
          style: CustomTextStyles.f18W600(
            color: AppColors.primaryColor,
          ),
        ),
        Text(
          "${cc.currentUser.value?.email}",
          style: CustomTextStyles.f16W300(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
