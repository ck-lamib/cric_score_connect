import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class FriendTile extends StatelessWidget {
  const FriendTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.backGroundColor,
                  width: 1,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                ImagePath.defaultAvatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizeConfig.getSpace(
            width: 20,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Bimal khatri",
                  style: CustomTextStyles.f18W600(
                      // color: AppColors.primaryColor,
                      ),
                ),
                Text(
                  "@bimal123",
                  style: CustomTextStyles.f14W500(
                    color: AppColors.hintTextColor,
                  ),
                ),
                SizeConfig.getSpace(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        title: "Confirm",
                        padding: EdgeInsets.zero,
                        backGroundColor: Colors.blue,
                        height: 40,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomElevatedButton(
                        title: "Reject",
                        backGroundColor: AppColors.errorColor,
                        padding: EdgeInsets.zero,
                        height: 40,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
