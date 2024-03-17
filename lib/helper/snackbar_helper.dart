import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/utils/app_colors.dart';

class AppSnackBar {
  static void showErrorSnackBar({required String message, required String title}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      borderRadius: 8,
      backgroundColor: Colors.black45,
      animationDuration: const Duration(milliseconds: 500),
      barBlur: 10,
      colorText: AppColors.whiteColor,
      isDismissible: false,
    );
  }
}
