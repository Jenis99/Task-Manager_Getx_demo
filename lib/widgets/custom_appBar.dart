import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/utils/size_utils.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.backGroundColor,
    this.title,
    this.leading,
    this.leadingIconColor,
    this.action,
    this.centerTitle,
    this.elevation,
    this.leadingWidth,
    this.shadowColor,
    this.bottom,
    this.appBarSize,
    this.automaticallyImplyLeading,
  }) : super(key: key);

  final Color? backGroundColor;
  final Color? shadowColor;
  final Color? leadingIconColor;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? action;
  final double? elevation;
  final double? leadingWidth;
  final double? appBarSize;
  final bool? centerTitle;
  final bool? automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(SizeUtils.horizontalBlockSize * 17),
      child: AppBar(
        backgroundColor: backGroundColor ?? AppColors.whiteColor,
        title: title,
        automaticallyImplyLeading: automaticallyImplyLeading ?? true,
        leading: (automaticallyImplyLeading ?? true) && leading == null
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: leadingIconColor ?? AppColors.whiteColor,
                  size: 23,
                ),
              )
            : leading,
        actions: action,
        elevation: elevation ?? 0,
        centerTitle: centerTitle ?? false,
        shadowColor: shadowColor ?? AppColors.whiteColor,
        leadingWidth: leadingWidth,
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarSize ?? 58);
}
