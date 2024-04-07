import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class CommonSilverAppBar extends StatelessWidget {
  const CommonSilverAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.leading,
    this.hasLeading = false,
    this.action,
    this.hasNotification = false,
    this.scrolledUnderElevation = 0,
    this.floating = true,
    this.pinned = false,
    this.collapsedHeight,
    this.expandedHeight,
    this.toolbarHeight = kToolbarHeight * 1.2,
  });

  final String title;
  final TextStyle? titleStyle;
  final Widget? leading;
  final bool hasLeading;
  final Widget? action;
  final bool hasNotification;
  final double scrolledUnderElevation;
  final bool floating;
  final bool pinned;
  final double? collapsedHeight;
  final double? expandedHeight;
  final double toolbarHeight;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.backGroundColor,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: scrolledUnderElevation,
      floating: floating,
      pinned: pinned,
      collapsedHeight: collapsedHeight,
      expandedHeight: expandedHeight,
      toolbarHeight: toolbarHeight,
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                leading ??
                    (hasLeading
                        ? InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 22,
                              color: AppColors.primaryColor,
                            ),
                          )
                        : const SizedBox.shrink()),
                leading != null || hasLeading == true
                    ? const SizedBox(
                        width: 15,
                      )
                    : const SizedBox.shrink(),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: titleStyle ??
                        CustomTextStyles.f24W600(
                          color: AppColors.primaryColor,
                        ),
                  ),
                ),
                action ??
                    (hasNotification
                        ? InkWell(
                            borderRadius: BorderRadius.circular(360),
                            onTap: () {},
                            child: const Center(
                              child: Icon(
                                Icons.notifications_active,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        : const SizedBox.shrink()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
