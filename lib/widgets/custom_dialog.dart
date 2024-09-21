import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void showError(String message) {
    Get.dialog(
      AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  static void showSuccess(String message) {
    Get.dialog(
      AlertDialog(
        title: Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}