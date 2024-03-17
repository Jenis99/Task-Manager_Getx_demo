import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:task_manager/model/get_data_model.dart';
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

class AddSubTaskScreen extends StatefulWidget {
  const AddSubTaskScreen({super.key});

  @override
  State<AddSubTaskScreen> createState() => _AddSubTaskScreenState();
}

class _AddSubTaskScreenState extends State<AddSubTaskScreen> {
  final AddTaskController addTaskController = Get.find();
  var arg;

  @override
  void initState() {
    // TODO: implement initState
    arg = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backGroundColor: AppColors.blackColor,
        automaticallyImplyLeading: true,
        title: AppText(
          text: AppString.addSubTask,
          color: AppColors.whiteColor,
        ),
      ),
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: addTaskController.subTaskAddFormKey,
              child: Padding(
                padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimationLimiter(
                      child: ListView.builder(
                        itemCount: addTaskController.textEditingList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              delay: const Duration(milliseconds: 300),
                              child: SlideAnimation(
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: FadeInAnimation(
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    duration: const Duration(milliseconds: 1000),
                                    child: Column(
                                      children: [
                                        addTaskTextFormField(
                                          titleText: AppString.name,
                                          controller: addTaskController.textEditingList[index].name,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          validator: AppValidator.nameValidation,
                                        ),
                                        addTaskTextFormField(
                                          titleText: AppString.description,
                                          controller: addTaskController.textEditingList[index].description,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          validator: AppValidator.descriptionValidation,
                                        ),
                                      ],
                                    ),
                                  )));
                        },
                      ),
                    ),
                    SizedBox(height: SizeUtils.horizontalBlockSize * 5),
                    GestureDetector(
                      onTap: () {
                        TextEditingController nameController = TextEditingController();
                        TextEditingController descriptionController = TextEditingController();
                        TextEditingModel textEditingModel = TextEditingModel(
                          description: descriptionController,
                          name: nameController,
                        );

                        addTaskController.textEditingList.add(textEditingModel);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.blackColor,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              size: SizeUtils.fSize_14(),
                            ),
                          ),
                          const SizedBox(width: 5),
                          AppText(
                            text: AppString.addSubTask2,
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeUtils.horizontalBlockSize * 10),
                    Obx(
                      () => CustomButton(
                        onTap: () async {
                          if (addTaskController.subTaskAddFormKey.currentState!.validate()) {
                            for (int i = 0; i < (addTaskController.textEditingList.length ?? 0); i++) {
                              SubTaskModel subTaskModel = SubTaskModel(
                                addTaskController.textEditingList[i].description.text,
                                addTaskController.textEditingList[i].name.text,
                              );
                              await addTaskController.updateTask(
                                id: arg[0]["docId"],
                                data: subTaskModel,
                              );
                              Get.back();
                            }
                          }
                        },
                        buttonColor: AppColors.blackColor,
                        textColor: AppColors.whiteColor,
                        text: addTaskController.isAddingSubTask.value ? AppString.addingData : AppString.addSubTask,
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
      ),
    );
  }
}
