import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onTap;
  final double height;
  final bool isDisabled;
  final Color? backGroundColor;
  final Color? textColor;
  final Size? fixedSize;
  const CustomOutlineButton({
    super.key,
    required this.title,
    this.titleWidget,
    this.padding,
    required this.onTap,
    this.height = 50,
    this.isDisabled = false,
    this.backGroundColor = AppColors.primaryColor,
    this.textColor,
    this.fixedSize,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: padding,
          backgroundColor: backGroundColor,
          minimumSize: Size.fromHeight(height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          fixedSize: fixedSize,
        ),
        onPressed: isDisabled ? null : onTap,
        child: titleWidget ??
            Text(
              title,
              textAlign: TextAlign.center,
              style: CustomTextStyles.f16W600(
                  color: textColor ?? AppColors.backGroundColor),
            ));
  }
}
