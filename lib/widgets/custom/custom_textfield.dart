import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final Function(String)? onValueChange;
  final FocusNode? focusNode;
  final String? hint;
  final String? preIconSvgPath;
  final Widget? preIconPath;
  final String? suffixIconSvgPath;
  final Widget? suffixIconPath;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color? border;
  final Color? fillColor;
  final bool? readOnly;
  final bool? showError;
  final bool? autofocus;
  final String? labelText;
  final double borderRadius;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final int? maxCharacters;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final TextStyle? style;

  const CustomTextField({
    super.key,
    this.fillColor,
    this.hint,
    this.preIconSvgPath,
    this.preIconPath,
    this.suffixIconSvgPath,
    this.suffixIconPath,
    this.onValueChange,
    this.controller,
    this.validator,
    required this.textInputAction,
    required this.textInputType,
    this.border,
    this.readOnly = false,
    this.showError = true,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onSubmitted,
    this.autofocus = false,
    this.maxCharacters,
    this.focusNode,
    required this.labelText,
    this.borderRadius = 8,
    this.inputFormatters,
    this.autofillHints,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: autofillHints,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      maxLength: maxCharacters,
      autofocus: autofocus!,
      textCapitalization: textCapitalization,
      onFieldSubmitted: onSubmitted,
      onTap: (onTap != null) ? onTap! : null,
      readOnly: (readOnly == null) ? false : readOnly!,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      maxLines: 1,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      validator: (validator != null) ? validator : null,
      controller: (controller != null) ? controller : null,
      cursorColor: AppColors.backGroundColor,
      onChanged: (text) {
        if (onValueChange != null) {
          onValueChange!(text);
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        label: labelText != null
            ? Text(
                labelText ?? "",
                style: CustomTextStyles.f16W400(
                  color: AppColors.hintTextColor,
                ),
              )
            : null,
        fillColor: fillColor ?? Colors.white,
        filled: true,
        prefixIcon: (preIconSvgPath != null || preIconPath != null)
            ? preIconPath ??
                SvgPicture.asset(
                  preIconSvgPath!,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    AppColors.hintTextColor,
                    BlendMode.srcIn,
                  ),
                )
            : null,
        suffixIcon: (suffixIconSvgPath != null || suffixIconPath != null)
            ? suffixIconPath ??
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    suffixIconSvgPath!,
                    fit: BoxFit.scaleDown,
                    height: 5,
                    width: 5,
                    colorFilter: const ColorFilter.mode(
                      AppColors.hintTextColor,
                      BlendMode.srcIn,
                    ),
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
        errorStyle: const TextStyle(fontSize: 12),
        hintText: hint,
        hintStyle: CustomTextStyles.f16W400(color: AppColors.hintTextColor),
      ),
      style: style ??
          CustomTextStyles.f16W400(
              color: (readOnly ?? false)
                  ? AppColors.hintTextColor
                  : AppColors.backGroundColor),
    );
  }
}
