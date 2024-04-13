import 'package:cached_network_image/cached_network_image.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_outline_button.dart';
import 'package:flutter/material.dart';

class SearchFriendTile extends StatelessWidget {
  final User? user;
  const SearchFriendTile({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    print(user!.profilePhotoPath!);
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
            child: user?.profilePhotoPath != null
                ? Container(
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
                    child: CachedNetworkImage(
                      imageUrl: user!.profilePhotoPath!,
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
                : Container(
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
                  user?.name ?? "Demo User",
                  style: CustomTextStyles.f18W600(
                      // color: AppColors.primaryColor,
                      ),
                ),
                Text(
                  user?.username ?? "@demo123",
                  style: CustomTextStyles.f14W500(
                    color: AppColors.hintTextColor,
                  ),
                ),
                SizeConfig.getSpace(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        title: "Add Friend",
                        padding: EdgeInsets.zero,
                        backGroundColor: Colors.blue,
                        height: 40,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomOutlineButton(
                        title: "View Profile",
                        // backGroundColor: AppColors.errorColor,
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
