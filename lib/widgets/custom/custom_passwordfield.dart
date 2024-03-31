import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomPasswordField extends StatelessWidget {
  final String? hint;
  final FocusNode? focusNode;
  final bool eye;
  final VoidCallback onEyeClick;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final Function(String)? onSubmitted;
  final double borderRadius;
  final String? labelText;

  const CustomPasswordField({
    super.key,
    this.hint,
    required this.eye,
    required this.onEyeClick,
    required this.controller,
    required this.textInputAction,
    required this.labelText,
    this.validator,
    this.onSubmitted,
    this.focusNode,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.backGroundColor,
      focusNode: focusNode,
      onFieldSubmitted: onSubmitted,
      controller: controller,
      validator: validator ?? Validators.checkPasswordField,
      obscureText: eye,
      maxLines: 1,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      textInputAction: textInputAction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        fillColor: Colors.white,
        filled: true,
        label: labelText != null
            ? Text(
                labelText ?? "",
                style: CustomTextStyles.f16W400(
                  color: AppColors.hintTextColor,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: const BorderSide(
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: const BorderSide(
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: const BorderSide(
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: const BorderSide(
            width: 1,
          ),
        ),
        prefixIcon: const Icon(
          Icons.password_rounded,
          color: AppColors.hintTextColor,
        ),
        suffixIcon: IconButton(
          onPressed: onEyeClick,
          icon: (eye)
              ? SvgPicture.asset(
                  ImagePath.eyeOff,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                  fit: BoxFit.scaleDown,
                )
              : SvgPicture.asset(
                  ImagePath.eye,
                  height: 12,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                  fit: BoxFit.scaleDown,
                ),
        ),
        errorStyle: const TextStyle(fontSize: 12),
        hintText: hint,
        hintStyle: CustomTextStyles.f16W400(color: AppColors.hintTextColor),
      ),
      style: CustomTextStyles.f16W400(color: AppColors.backGroundColor),
    );
  }
}
