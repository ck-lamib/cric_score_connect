import 'package:cric_score_connect/screens/profile/widgets/profile_friend_stat.dart';
import 'package:cric_score_connect/screens/profile/widgets/profile_user_detail.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileUpperSection extends StatelessWidget {
  const ProfileUpperSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          bottom: 35,
          child: Container(
            color: AppColors.backGroundColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              ProfileUserDetailCard(),
              const SizedBox(
                height: 15,
              ),
              const ProfileFrientStats(),
            ],
          ),
        ),
      ],
    );
  }
}
