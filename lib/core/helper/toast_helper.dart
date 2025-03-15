import 'package:flutter/material.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:toastification/toastification.dart';

class ToastHelper {
  static void showSuccessToast({
    required BuildContext context,
    required String message,
  }) {
    toastification.show(
      context: context,
      title: Text(
        message,
        style: TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppColors.successToastColor,
        ),
      ),
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static void showErrorToast({
    required BuildContext context,
    required String message,
  }) {
    toastification.show(
      context: context,
      title: Text(
        message,
        style: TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppColors.failureToastColor,
        ),
      ),
      type: ToastificationType.error,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
