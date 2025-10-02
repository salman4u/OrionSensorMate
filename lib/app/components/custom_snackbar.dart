import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static showCustomSnackBar({required String title, required String message,Duration? duration})
  {
    try {
      Get.snackbar(
        title,
        message,
        duration: duration ?? const Duration(seconds: 3),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(Get.context as BuildContext).size.height - 200,
            right: 20,
            left: 20),
        colorText: Colors.white,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check_circle, color: Colors.white,),
      );
    }
    catch(e){
      e.printError();
    }
  }


  static showCustomErrorSnackBar({required String title, required String message,Color? color,Duration? duration})
  {
    try {
      Get.snackbar(
        title,
        message,
        duration: duration ?? const Duration(seconds: 3),
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        colorText: Colors.white,
        backgroundColor: color ?? Colors.redAccent,
        icon: const Icon(Icons.error, color: Colors.white,),
      );
    }
    catch(e){
      e.printError();
    }
  }



  static showCustomToast({String? title, required String message,Color? color,Duration? duration}){
    Get.rawSnackbar(
      title: title,
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: color ?? Colors.green,
      onTap: (snack){
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
      message: message,
    );
  }


  static showCustomErrorToast({String? title, required String message,Color? color,Duration? duration}){
    try {
      Get.rawSnackbar(
        title: title,
        duration: duration ?? const Duration(seconds: 3),
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.TOP,
        backgroundColor: color ?? Colors.redAccent,
        onTap: (snack) {
          Get.closeAllSnackbars();
        },
        //overlayBlur: 0.8,
        message: message,
      );
    }
    catch(e){
      e.printError();
    }
  }
}
