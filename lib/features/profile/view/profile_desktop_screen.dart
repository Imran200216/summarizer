import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:summarize/core/helper/toast_helper.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:summarize/features/auth/view_modal/google_sign_in_provider.dart';

class ProfileDesktopScreen extends StatelessWidget {
  const ProfileDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLogoutDialog(context); // Automatically show the dialog
    });

    return Scaffold();
  }

  /// Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.subTitleColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final googleSignInProvider = Provider.of<GoogleSignInProvider>(
                  context,
                  listen: false,
                );

                bool isSuccess = await googleSignInProvider.logout();

                Navigator.of(context).pop(); // Close dialog

                if (isSuccess) {
                  ToastHelper.showSuccessToast(
                    context: context,
                    message: "Logged out successfully",
                  );

                  /// auth login screen
                  GoRouter.of(context).pushReplacementNamed("authLogin");
                } else {
                  ToastHelper.showErrorToast(
                    context: context,
                    message: "Logout failed. Please try again.",
                  );
                }
              },
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.subTitleColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
