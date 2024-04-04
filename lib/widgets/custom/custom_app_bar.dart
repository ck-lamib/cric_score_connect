import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.hasLeading = true,
    this.automaticallyImplyLeading = false,
    this.title,
    this.flexibleSpace,
    this.actions,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle = true,
    this.leadingWidth = 24,
    this.titleTextStyle,
    this.bottom,
    this.bottomOpacity = 1.0,
    this.titileSpacing,
    this.padding,
    this.titleWidget,
  });
  final bool hasLeading;
  final bool automaticallyImplyLeading;
  final String? title;
  final Widget? titleWidget;
  final Widget? flexibleSpace;
  final List<Widget>? actions;
  final double? elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool? centerTitle;
  final double? leadingWidth;
  final TextStyle? titleTextStyle;
  final PreferredSizeWidget? bottom;
  final double bottomOpacity;
  final double? titileSpacing;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(24, 12, 24, 10),
      child: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.backGroundColor, // status bar color
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.backGroundColor,
        scrolledUnderElevation: 0,
        leading: hasLeading
            ? InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 23,
                  color: AppColors.backGroundColor,
                ))
            : null,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: title != null
            ? Text(title!,
                style: titleTextStyle ?? Theme.of(context).textTheme.titleLarge)
            : titleWidget,
        actions: actions,
        elevation: 0,
        // backgroundColor: backgroundColor ?? Colors.transparent,
        foregroundColor: foregroundColor,
        centerTitle: centerTitle,
        leadingWidth: leadingWidth,
        titleTextStyle: titleTextStyle,
        titleSpacing: titileSpacing,
        bottom: bottom,
        bottomOpacity: bottomOpacity,
        flexibleSpace: flexibleSpace,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
