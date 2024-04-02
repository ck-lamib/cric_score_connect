import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/screens/gameprofile/controller/game_profile_controller.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameProfileUserDetailCard extends StatelessWidget {
  GameProfileUserDetailCard({
    super.key,
  });

  final CoreController cc = Get.find<CoreController>();
  final GameProfileController c = Get.find<GameProfileController>();

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
              child: c.user?.profilePhotoPath != null
                  ? const CircleAvatar(
                      backgroundColor: AppColors.onBackGroundColor,
                      backgroundImage: NetworkImage(
                          "https://bimalkhatri.com.np/img/hell.png"),
                      radius: 55,
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
                  "@${c.user?.username}",
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
          "${c.user?.name}",
          style: CustomTextStyles.f18W600(
            color: AppColors.primaryColor,
          ),
        ),
        Text(
          "${c.user?.email}",
          style: CustomTextStyles.f16W300(
            color: AppColors.primaryColor,
          ),
        ),
        c.user?.username == cc.currentUser.value?.username
            ? const SizedBox.shrink()
            : Column(
                children: [
                  SizeConfig.getSpace(),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: CustomElevatedButton(
                      title: "Add Friend",
                      backGroundColor: Colors.blue,
                      onTap: () {},
                    ),
                  ),
                  SizeConfig.getSpace(),
                ],
              ),
      ],
    );
  }
}
