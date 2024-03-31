import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChangePasswordAppBar extends StatelessWidget {
  const ChangePasswordAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.backGroundColor,
          expandedHeight: height * 0.5,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                SizedBox(
                  height: height * 0.4,
                  child: SvgPicture.asset(
                    ImagePath.changePasswordUIImagePath,
                    alignment: Alignment.center,
                    height: height * 0.25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
