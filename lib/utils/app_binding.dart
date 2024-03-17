import 'package:get/get.dart';
import 'package:task_manager/modules/add_task/controller/add_task_controller.dart';
import 'package:task_manager/modules/auth/controller/auth_controller.dart';
import 'package:task_manager/modules/splash/controller/splash_controller.dart';

class AppBidding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    Get.put<AuthController>(AuthController());
    Get.put<AddTaskController>(AddTaskController());
  }
}
