import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/utils/size_utils.dart';
import 'package:task_manager/widgets/app_text.dart';
import 'package:task_manager/widgets/custom_textfield.dart';

Widget addTaskTextFormField({
  String? titleText,
  String? hintText,
  TextEditingController? controller,
  TextInputType? keyboardType,
  List<TextInputFormatter>? textInputFormatter,
  TextInputAction? textInputAction,
  TextCapitalization? textCapitalization,
  FormFieldValidator<String>? validator,
  int? maxLine,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      AppText(
        text: titleText ?? '',
        fontSize: SizeUtils.fSize_16(),
        fontWeight: FontWeight.bold,
      ),
      SizedBox(height: SizeUtils.horizontalBlockSize * 3),
      CustomTextField(
        hintText: hintText ?? '',
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        textInputFormatter: textInputFormatter,
        textInputAction: textInputAction ?? TextInputAction.done,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        validator: validator,
        maxLine: maxLine ?? 1,
      ),
      SizedBox(height: SizeUtils.horizontalBlockSize * 3),
    ],
  );
}
