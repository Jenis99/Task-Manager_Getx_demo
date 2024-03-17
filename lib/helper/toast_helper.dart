import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/utils/size_utils.dart';

class AppToast {
  static void toastMessage(String message, {Color? color}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: color,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: SizeUtils.horizontalBlockSize * 4,
    );
  }
}
