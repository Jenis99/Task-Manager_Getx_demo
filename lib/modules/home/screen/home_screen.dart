import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:task_manager/helper/shared_preference.dart';
import 'package:task_manager/model/get_data_model.dart';
import 'package:task_manager/modules/add_task/controller/add_task_controller.dart';
import 'package:task_manager/modules/home/controller/home_controller.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/utils/navigation/navigation.dart';
import 'package:task_manager/utils/size_utils.dart';
import 'package:task_manager/utils/strings_utils.dart';
import 'package:task_manager/widgets/app_text.dart';
import 'package:task_manager/widgets/custom_appBar.dart';
import 'package:task_manager/widgets/custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final AddTaskController addTaskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backGroundColor: AppColors.blackColor,
        automaticallyImplyLeading: false,
        title: AppText(
          text: AppString.homeScreen,
          color: AppColors.whiteColor,
        ),
        action: [
          IconButton(
            onPressed: () async {
              await deleteDialog(
                context: context,
                message: AppString.deleteAccount,
                noButton: () {
                  Get.back();
                },
                yesButton: () {
                  AppSharedPreference.clear();
                  Get.offAllNamed(Routes.loginScreen);
                },
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.addTask);
        },
        backgroundColor: AppColors.blackColor,
        splashColor: AppColors.transparent,
        child: Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
      body: Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Task")
                .where('userId', isEqualTo: AppSharedPreference.accessToken())
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              homeController.projectModel.clear();
              snapshot.data?.docs.forEach((element) {
                GetTaskModel requestedModel = GetTaskModel.fromJson(element.data() as Map<String, dynamic>);
                homeController.projectModel.add(requestedModel);
              });

              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return homeController.projectModel.isEmpty
                      ? const AppText(text: "No Data Available")
                      : AnimationLimiter(
                          child: ListView.builder(
                            itemCount: homeController.projectModel.length,
                            itemBuilder: (context, i) {
                              return AnimationConfiguration.staggeredList(
                                position: i,
                                delay: const Duration(milliseconds: 300),
                                child: SlideAnimation(
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: FadeInAnimation(
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    duration: const Duration(milliseconds: 1000),
                                    child: addBox(
                                      deleteOnTap: () async {
                                        await deleteDialog(
                                          context: context,
                                          message: AppString.deleteTask,
                                          noButton: () {
                                            Get.back();
                                          },
                                          yesButton: () {
                                            Get.back();
                                            homeController.deleteRecords(homeController.projectModel[i].docId.toString());
                                          },
                                        );
                                      },
                                      docId: homeController.projectModel[i].docId.toString(),
                                      getSubTaskModel: homeController.projectModel[i].subTaskModel,
                                      name: homeController.projectModel[i].name,
                                      description: homeController.projectModel[i].description,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                } else if (snapshot.hasError) {
                  log("${snapshot.error}");
                  return const Text("Snapshot has error");
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }

  addBox({
    GestureTapCallback? deleteOnTap,
    String? name,
    String? description,
    String? docId,
    List<GetSubTaskModel>? getSubTaskModel,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.horizontalBlockSize * 5.0,
        vertical: SizeUtils.horizontalBlockSize * 2.0,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.blackColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Theme(
              data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                iconColor: AppColors.grey,
                title: Row(
                  children: [
                    AppText(
                      text: "Name: $name",
                      fontWeight: FontWeight.w600,
                      fontSize: SizeUtils.fSize_15(),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: deleteOnTap,
                        child: AppText(
                          text: "Delete",
                          fontWeight: FontWeight.w600,
                          fontSize: SizeUtils.fSize_12(),
                          color: AppColors.redColor,
                        ),
                      ),
                    ),
                  ],
                ),
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Description: $description",
                              fontWeight: FontWeight.w600,
                              fontSize: SizeUtils.fSize_13(),
                              color: AppColors.blackColor.withOpacity(0.6),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                              text: "Sub task count : ${getSubTaskModel?.length ?? 0}",
                              fontWeight: FontWeight.w400,
                              fontSize: SizeUtils.fSize_13(),
                              color: AppColors.grey,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: GestureDetector(
                          onTap: () {
                            addTaskController.textEditingList.clear();
                            TextEditingController nameController = TextEditingController();
                            TextEditingController descriptionController = TextEditingController();
                            TextEditingModel textEditingModel = TextEditingModel(
                              description: descriptionController,
                              name: nameController,
                            );

                            addTaskController.textEditingList.add(textEditingModel);
                            Get.toNamed(
                              Routes.addSubTaskScreen,
                              arguments: [
                                {
                                  'docId': docId,
                                }
                              ],
                            );
                          },
                          child: Container(
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
                        ),
                      ),
                    ],
                  ),
                  AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: getSubTaskModel?.length ?? 0,
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
                              child: subTaskBox(
                                name: getSubTaskModel?[index].name,
                                description: getSubTaskModel?[index].description,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget subTaskBox({
    String? name,
    String? description,
  }) {
    return Theme(
      data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          iconColor: AppColors.grey,
          title: Row(
            children: [
              AppText(
                text: "Sub Name: $name",
                fontWeight: FontWeight.w600,
                fontSize: SizeUtils.fSize_15(),
              ),
            ],
          ),
          children: [
            Row(
              children: [
                Expanded(
                  flex: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Sub Description: $description",
                        fontWeight: FontWeight.w600,
                        fontSize: SizeUtils.fSize_13(),
                        color: AppColors.blackColor.withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
