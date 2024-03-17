import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/utils/app_binding.dart';
import 'package:task_manager/utils/navigation/navigation.dart';
import 'package:task_manager/utils/strings_utils.dart';

class TaskManagerProject extends StatelessWidget {
  const TaskManagerProject({super.key});
  @override
  Widget build(BuildContext context) {
    hideKeyboard(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: Routes.pages,
      initialBinding: AppBidding(),
      title: AppString.appName,
    );
  }
  void hideKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
