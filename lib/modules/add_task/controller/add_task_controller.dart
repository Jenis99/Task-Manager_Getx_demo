import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/helper/shared_preference.dart';
import 'package:task_manager/model/get_data_model.dart';
import 'package:task_manager/model/set_data_model.dart';

class AddTaskController extends GetxController {
  ///add task
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final addTaskFormKey = GlobalKey<FormState>();
  List<TextEditingController> nameListController = <TextEditingController>[].obs;
  List<TextEditingController> descriptionListController = <TextEditingController>[].obs;

  ///add sub task
  TextEditingController subTaskNameController = TextEditingController();
  TextEditingController subTaskDescriptionController = TextEditingController();
  final subTaskAddFormKey = GlobalKey<FormState>();

  RxBool isAddingTask = false.obs;
  RxBool isAddingSubTask = false.obs;

  Future<void> setAllData(SetTaskModel data) async {
    isAddingTask.value = true;
    String id = FirebaseFirestore.instance.collection("Task").doc().id;
    data.docId = id;
    data.time = DateTime.now();
    data.userId = AppSharedPreference.accessToken();
    await FirebaseFirestore.instance
        .collection("Task")
        .doc(id)
        .set(
          data.toJson(),
        )
        .then((value) => isAddingTask.value = false)
        .catchError((error) {
      print("Failed to add user: ${error}");
      isAddingTask.value = false;
    });

    clearField();
  }

  clearField() {
    nameController.clear();
    descriptionController.clear();
  }

  RxList<TextEditingModel> textEditingList = <TextEditingModel>[].obs;

  Future<void> updateTask({
    required String id,
    required SubTaskModel data,
  }) async {
    isAddingSubTask.value = true;
    await FirebaseFirestore.instance
        .collection("Task")
        .doc(id)
        .update({
          "subTaskModel": FieldValue.arrayUnion([data.toMap()])
        })
        .then((value) => isAddingSubTask.value = false)
        .catchError((error) => print("Failed to add sub task: ${error}"));
    isAddingSubTask.value = false;
    clearField();
  }
}
