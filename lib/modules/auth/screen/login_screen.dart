import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/modules/auth/controller/auth_controller.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/utils/size_utils.dart';
import 'package:task_manager/utils/strings_utils.dart';
import 'package:task_manager/utils/validation_utils.dart';
import 'package:task_manager/widgets/app_text.dart';
import 'package:task_manager/widgets/custom_button.dart';
import 'package:task_manager/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5.0),
            child: Form(
              key: authController.authFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeUtils.horizontalBlockSize * 20),
                  AppText(
                    text: AppString.logIn,
                    fontSize: SizeUtils.fSize_30(),
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: SizeUtils.horizontalBlockSize * 20),
                  CustomTextField(
                    controller: authController.userNameController,
                    hintText: AppString.userName,
                    validator: AppValidator.userNameValidation,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: SizeUtils.horizontalBlockSize * 5),
                  CustomTextField(
                    controller: authController.passwordController,
                    hintText: AppString.password,
                    validator: AppValidator.passwordValidation,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: SizeUtils.horizontalBlockSize * 18),
                  Obx(
                    () => CustomButton(
                      onTap: () async {
                        if (authController.authFormKey.currentState!.validate()) {
                          await authController.readJson();
                          await authController.login(
                            email: authController.userNameController.text.trim(),
                            password: authController.passwordController.text.trim(),
                          );
                        }
                      },
                      text: authController.isLoginLoading.value ? AppString.loading : AppString.logIn,
                      textColor: AppColors.whiteColor,
                      buttonColor: AppColors.blackColor,
                      fontSize: SizeUtils.fSize_18(),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
