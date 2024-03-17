import 'package:get/get.dart';
import 'package:task_manager/helper/shared_preference.dart';
import 'package:task_manager/utils/navigation/navigation.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    openScreen();
  }

  void openScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    print('AppSharedPreference.accessToken()-->${AppSharedPreference.accessToken()}');
    AppSharedPreference.accessToken().isEmpty ? Get.offAndToNamed(Routes.loginScreen) : Get.offAndToNamed(Routes.home);
  }
}
