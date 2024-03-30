import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:cric_score_connect/screens/personalinfo/controller/personal_info_controller.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoAppBar extends StatelessWidget {
  PersonalInfoAppBar({
    super.key,
  });

  final PersonalInfoController c = Get.find<PersonalInfoController>();

  @override
  Widget build(BuildContext context) {
    return CommonSilverAppBar(
      hasLeading: true,
      title: "Personal Information",
      titleStyle: CustomTextStyles.f18W600(
        color: AppColors.primaryColor,
      ),
      action: Obx(
        () => c.isEditTap
            ? ElevatedButton(
                onPressed: c.onEditToggle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: Text(
                  "Cancel",
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.f18W600(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            : ElevatedButton(
                onPressed: c.onEditToggle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: Text(
                  "Edit",
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.f18W600(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
      ),
      hasNotification: false,
      scrolledUnderElevation: 0,
      floating: false,
      pinned: true,
      toolbarHeight: kToolbarHeight * 1.5,
    );
  }
}
