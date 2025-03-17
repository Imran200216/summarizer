import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:summarize/commons/provider/internet_checker_provider.dart';
import 'package:summarize/commons/widgets/custom_icon_filled_btn.dart';
import 'package:summarize/commons/widgets/custom_text_field.dart';
import 'package:summarize/core/helper/toast_helper.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:summarize/core/validator/app_validator.dart';
import 'package:summarize/features/auth/view_modal/email_password_auth_provider.dart';

class AuthForgetPasswordMobileScreen extends StatelessWidget {
  const AuthForgetPasswordMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// controller
    final TextEditingController emailForgetPasswordController =
        TextEditingController();

    /// form key
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Consumer2<EmailPasswordAuthProvider, InternetCheckerProvider>(
      builder: (
        context,
        emailPasswordAuthProvider,
        internetCheckerProvider,
        child,
      ) {
        return Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Keeps column as small as possible
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Forget password title
                Text(
                  "Forget Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.subTitleColor,
                  ),
                ),

                SizedBox(height: 20.h),

                /// Email text field
                CustomTextField(
                  validator: AppValidator.validatePassword,
                  textEditingController: emailForgetPasswordController,
                  hintText: "email",
                  labelText: "Email Address",
                  prefixIcon: Icons.alternate_email,
                ),

                SizedBox(height: 40),

                /// Forget password link button
                CustomIconFilledBtn(
                  onTap: () async {
                    /// Show SnackBar and STOP execution if no internet connection
                    if (!internetCheckerProvider.isNetworkConnected) {
                      ToastHelper.showErrorToast(
                        context: context,
                        message:
                            "No internet connection. Please check your network.",
                      );
                      return;
                    }

                    if (formKey.currentState!.validate()) {
                      bool isSuccess = await emailPasswordAuthProvider
                          .sendPasswordResetEmail(
                            emailForgetPasswordController.text.trim(),
                            context,
                          );

                      if (isSuccess) {
                        /// Navigate to home
                        GoRouter.of(context).pushReplacementNamed("authLogin");
                      } else {
                        ToastHelper.showErrorToast(
                          context: context,
                          message: "Failure in Sending link",
                        );
                      }
                    }
                  },
                  btnTitle: "Send link",
                  iconPath: "login",
                  fontSize: 12.sp,
                ),

                SizedBox(height: 20.h),

                /// back to login text btn
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed("authLogin");
                  },
                  child: Text(
                    "Back to Login",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
