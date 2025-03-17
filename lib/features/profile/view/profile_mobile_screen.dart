import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:summarize/core/helper/toast_helper.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:summarize/features/auth/view_modal/google_sign_in_provider.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// current user
    final User? user = FirebaseAuth.instance.currentUser;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Profile Photo
            CircleAvatar(
              radius: 40.r,
              backgroundImage:
                  user?.photoURL != null
                      ? CachedNetworkImageProvider(user!.photoURL!)
                      : const AssetImage(
                            "assets/images/jpg/person-placeholder.jpeg",
                          )
                          as ImageProvider, // Default Image
            ),

            SizedBox(height: 40.h),

            /// user name
            Text(
              user?.displayName ?? "User",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.subTitleColor,
              ),
            ),

            SizedBox(height: 20.h),

            /// user email
            Text(
              user?.email ?? "No Email Found",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.subTitleColor,
              ),
            ),

            SizedBox(height: 20.h),

            /// Logout text button
            TextButton(
              onPressed: () {
                _showLogoutDialog(context);
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14.sp,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
