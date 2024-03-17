import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/model/set_data_model.dart';
import 'package:task_manager/modules/add_task/controller/add_task_controller.dart';
import 'package:task_manager/modules/add_task/widget/add_task_textfield.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/utils/size_utils.dart';
import 'package:task_manager/utils/strings_utils.dart';
import 'package:task_manager/utils/validation_utils.dart';
import 'package:task_manager/widgets/app_text.dart';
import 'package:task_manager/widgets/custom_appBar.dart';
import 'package:task_manager/widgets/custom_button.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);
  final AddTaskController addTaskController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backGroundColor: AppColors.blackColor,
        automaticallyImplyLeading: true,
        title: AppText(

          text: AppString.addTask,
          color: AppColors.whiteColor,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: addTaskController.addTaskFormKey,
            child: Padding(
              padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addTaskTextFormField(
                    titleText: AppString.name,
                    controller: addTaskController.nameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: AppValidator.nameValidation,
                  ),
                  addTaskTextFormField(
                    titleText: AppString.description,
                    controller: addTaskController.descriptionController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: AppValidator.descriptionValidation,
                  ),
                  SizedBox(height: SizeUtils.horizontalBlockSize * 10),
                  Obx(
                    () => CustomButton(
                      onTap: () async {
                        if (addTaskController.addTaskFormKey.currentState!.validate()) {
                          SetTaskModel projectModel = SetTaskModel(
                            description: addTaskController.descriptionController.text,
                            name: addTaskController.nameController.text,
                          );
                          await addTaskController.setAllData(projectModel);
                          Get.back();
                        }
                      },
                      buttonColor: AppColors.blackColor,
                      textColor: AppColors.whiteColor,
                      text: addTaskController.isAddingTask.value ? AppString.addingData : AppString.addTask,
                      fontWeight: FontWeight.w700,
                      fontSize: SizeUtils.fSize_18(),
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
