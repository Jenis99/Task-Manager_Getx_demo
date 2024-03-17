import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/modules/splash/controller/splash_controller.dart';
import 'package:task_manager/utils/size_utils.dart';
import 'package:task_manager/utils/strings_utils.dart';
import 'package:task_manager/widgets/app_text.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final SplashController splashController = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return const Scaffold(
      body: Center(
        child: AppText(
          text: AppString.appName,
        ),
      ),
    );
  }
}
