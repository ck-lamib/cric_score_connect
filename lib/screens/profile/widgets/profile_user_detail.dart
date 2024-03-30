import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileUserDetailCard extends StatelessWidget {
  const ProfileUserDetailCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              // margin: EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                backgroundColor: AppColors.onBackGroundColor,
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
                  "@bimal@123456",
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
          "Bibek Khatri",
          style: CustomTextStyles.f18W600(
            color: AppColors.primaryColor,
          ),
        ),
        Text(
          "bimal@gmail.com",
          style: CustomTextStyles.f16W300(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
