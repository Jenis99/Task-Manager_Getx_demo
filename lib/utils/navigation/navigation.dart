import 'package:get/get.dart';
import 'package:task_manager/modules/add_task/screen/add_sub_task_screen.dart';
import 'package:task_manager/modules/add_task/screen/add_task_screen.dart';
import 'package:task_manager/modules/auth/screen/login_screen.dart';
import 'package:task_manager/modules/home/screen/home_screen.dart';
import 'package:task_manager/modules/splash/screen/splash_screen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  static const String splash = '/splash';
  static const String loginScreen = '/loginScreen';
  static const String home = '/home';
  static const String addTask = '/addTask';
  static const String addSubTaskScreen = '/addSubTaskScreen';

  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: splash,
      page: () => SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: loginScreen,
      page: () => LoginScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: home,
      page: () => HomeScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: addTask,
      page: () => AddTaskScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: addSubTaskScreen,
      page: () => AddSubTaskScreen(),
      transition: defaultTransition,
    ),
  ];
}
