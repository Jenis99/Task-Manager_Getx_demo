import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/utils/size_utils.dart';
import 'package:task_manager/widgets/app_text.dart';

import 'custom_button.dart';

Future<void> deleteDialog({
  required Function() noButton,
  required Function() yesButton,
  String? message,
  context,
}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 5),
          ),
          title: Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 5),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.horizontalBlockSize * 1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColors.blackColor,
                        size: 29,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeUtils.horizontalBlockSize * 4),
                  AppText(
                    fontSize: SizeUtils.fSize_14(),
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                    textAlign: TextAlign.center,
                    text: message ?? '',
                  ),
                  SizedBox(height: SizeUtils.horizontalBlockSize * 8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          height: SizeUtils.horizontalBlockSize * 10.4,
                          onTap: yesButton,
                          text: "Yes",
                          textColor: AppColors.whiteColor,
                          buttonColor: AppColors.redColor,
                        ),
                      ),
                      SizedBox(
                        width: SizeUtils.horizontalBlockSize * 2,
                      ),
                      Expanded(
                        child: CustomButton(
                          height: SizeUtils.horizontalBlockSize * 10.4,
                          onTap: noButton,
                          text: "No",
                          textColor: AppColors.whiteColor,
                          buttonColor: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeUtils.horizontalBlockSize * 2),
                ],
              ),
            ),
          ),
        );
      });
}
