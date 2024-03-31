import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownTextField extends StatelessWidget {
  final Function(String)? onValueChange;
  final FocusNode? focusNode;
  final String hint;

  final Widget? suffixIcon;

  final String? Function(String?)? validator;

  final Color? fillColor;

  final bool? autofocus;
  final String? labelText;
  final double borderRadius;
  final Function()? onTap;

  final TextStyle? hintStyle;
  final Widget? prefixIcon;

  final EdgeInsetsGeometry? contentPadding;

  // final int? maxLines;
  final List<DropdownMenuItem<String>> dropDownItemLists;
  final String? itemValue;

  const CustomDropdownTextField({
    super.key,
    this.fillColor,
    required this.hint,
    this.suffixIcon,
    this.onValueChange,
    this.validator,
    this.onTap,
    this.autofocus = false,
    this.focusNode,
    this.labelText,
    this.borderRadius = 8,
    this.prefixIcon,
    this.hintStyle,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20),
    required this.dropDownItemLists,
    this.itemValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2(
        alignment: Alignment.topLeft,
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.zero,
        ),
        value: itemValue,
        items: dropDownItemLists,
        focusNode: focusNode,
        autofocus: autofocus!,
        validator: (validator != null) ? validator : null,
        onChanged: (text) {
          if (onValueChange != null) {
            onValueChange!(text!);
          }
        },
        dropdownStyleData: DropdownStyleData(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          openInterval: const Interval(
            0,
            0.9,
            curve: Curves.easeIn,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
        ),
        iconStyleData: const IconStyleData(
          iconEnabledColor: AppColors.hintTextColor,
          // icon: Icon(
          //   Icons.keyboard_arrow_down_rounded,
          //   color: AppColor.dark,
          // ),
        ),
        decoration: InputDecoration(
          contentPadding: contentPadding,
          label: labelText != null
              ? Text(
                  labelText ?? "",
                )
              : null,
          fillColor: fillColor ?? Colors.white,
          filled: false,
          prefixIcon: prefixIcon,
          // suffixIcon: (suffixIcon != null) ? suffixIcon : null,

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
          errorStyle: const TextStyle(fontSize: 12, color: Colors.redAccent),
          hintText: hint,
          hintStyle: hintStyle ??
              CustomTextStyles.f16W400(color: AppColors.hintTextColor),
          // hintStyle: CustomTextStyles.f16W400(color: AppColors.hintTextColor),
        ),
        style: CustomTextStyles.f16W400(
          color: AppColors.hintTextColor,
        ),
      ),
    );

    // DropdownButtonFormField<String>(
    //   value: itemValue,
    //   items: dropDownItemLists,
    //   focusNode: focusNode,
    //   autofocus: autofocus!,

    //   validator: (validator != null) ? validator : null,
    //   onChanged: (text) {
    //     if (onValueChange != null) {
    //       onValueChange!(text!);
    //     }
    //   },
    //   borderRadius: BorderRadius.circular(16),
    //   isExpanded: false,
    //   icon: Icon(Icons.dry_outlined),
    //   dropdownColor: Colors.white,
    //   decoration: InputDecoration(
    //     contentPadding: contentPadding,
    //     label: labelText != null
    //         ? Text(
    //             labelText ?? "",
    //           )
    //         : null,
    //     fillColor: fillColor ?? AppColor.lightPink,
    //     filled: false,
    //     prefixIcon: prefixIcon,
    //     // suffixIcon: (suffixIcon != null) ? suffixIcon : null,
    //     enabledBorder: OutlineInputBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    //         borderSide: const BorderSide(color: AppColor.dark)),
    //     focusedErrorBorder: OutlineInputBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    //         borderSide: const BorderSide(color: AppColor.dark)),
    //     focusedBorder: OutlineInputBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    //         borderSide: const BorderSide(color: AppColor.dark)),
    //     errorBorder: OutlineInputBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    //         borderSide: const BorderSide(color: Colors.redAccent)),

    //     errorStyle: const TextStyle(fontSize: 12, color: Colors.redAccent),
    //     hintText: hint,
    //     hintStyle: hintStyle ?? theme.textTheme.bodySmall?.copyWith(color: AppColor.dark),
    //     // hintStyle: CustomTextStyles.f16W400(color: AppColors.hintTextColor),
    //   ),
    //   style: theme.textTheme.bodySmall?.copyWith(color: AppColor.dark),
    // );
  }
}
