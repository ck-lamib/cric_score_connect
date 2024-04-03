import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;
  final bool isDisabled;
  final Color? backGroundColor;
  final Color? textColor;
  final Size? fixedSize;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 50,
    this.isDisabled = false,
    this.backGroundColor = AppColors.backGroundColor,
    this.textColor,
    this.fixedSize,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: backGroundColor,
          minimumSize: Size.fromHeight(height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          fixedSize: fixedSize,
        ),
        onPressed: isDisabled ? null : onTap,
        child: Text(
          title,
          style: textStyle ??
              CustomTextStyles.f16W600(color: textColor ?? Colors.white),
        ));
  }
}
