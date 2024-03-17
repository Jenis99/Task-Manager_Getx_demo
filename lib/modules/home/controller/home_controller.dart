import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_manager/helper/toast_helper.dart';
import 'package:task_manager/model/get_data_model.dart';

class HomeController extends GetxController {
  RxList<GetTaskModel> projectModel = <GetTaskModel>[].obs;

  Future<void> deleteRecords(String id) async {
    FirebaseFirestore.instance.collection("Task").doc(id).delete().then((value) {
      AppToast.toastMessage("Record has been deleted successfully");
    });
  }
}
