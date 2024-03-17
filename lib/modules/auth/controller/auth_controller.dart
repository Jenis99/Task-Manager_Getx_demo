import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task_manager/helper/shared_preference.dart';
import 'package:task_manager/helper/toast_helper.dart';
import 'package:task_manager/utils/navigation/navigation.dart';

class AuthController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authFormKey = GlobalKey<FormState>();

  List loginModel = [].obs;
  RxBool isLoginLoading = false.obs;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/login_data.json');
    final Map<String, dynamic> data = await json.decode(response);
    print("data:- ${data}");
    List pokemons = [];
    data.forEach((final String key, final value) {
      pokemons.add(value);
    });
    print(pokemons);
    loginModel = pokemons;
    // loginModel.value = LoginModel.fromJson(data);
    print("loginModel:- ${loginModel.length}");
  }
  Future<void> login({
    required String email,
    required String password,
  }) async{
    try {
      isLoginLoading.value = true;
      loginModel.forEach((element) {
        if(email == element["username"] && password == element["Password"]) {
          AppToast.toastMessage("User logged in successfully");
          clear();
          AppSharedPreference.setJwtToken(element["username"]);
          Get.offAndToNamed(Routes.home);
        } else {
          AppToast.toastMessage("Please enter correct username and password");
        }
      });
    } catch (e, st) {
      isLoginLoading.value = false;
      log("e:- $e st:- $st");
    } finally {
      isLoginLoading.value = false;
    }
  }
  clear() {
    userNameController.clear();
    passwordController.clear();
  }
}
