import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:summarize/commons/provider/internet_checker_provider.dart';
import 'package:summarize/commons/widgets/custom_icon_filled_btn.dart';
import 'package:summarize/commons/widgets/custom_outlined_btn.dart';
import 'package:summarize/commons/widgets/custom_text_field.dart';
import 'package:summarize/core/helper/toast_helper.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:summarize/core/validator/app_validator.dart';
import 'package:summarize/features/auth/view/widgets/auth_arrow_container.dart';
import 'package:summarize/features/auth/view_modal/email_password_auth_provider.dart';
import 'package:summarize/features/auth/view_modal/google_sign_in_provider.dart';
import 'package:summarize/features/auth/view_modal/page_provider.dart';

class AuthLoginTabletScreen extends StatelessWidget {
  AuthLoginTabletScreen({super.key});

  /// controller
  final PageController _pageController = PageController();

  /// images
  final List<String> images = [
    "https://images.unsplash.com/photo-1682019652913-b61a48eeba4f?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1531297484001-80022131f5a1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ];

  /// descriptions
  final List<String> descriptions = [
    "Transform your workspace with modern design and seamless productivity.",
    "Innovate, collaborate, and build with cutting-edge technology.",
    "Unlock new possibilities with AI-driven insights and automation.",
  ];

  @override
  Widget build(BuildContext context) {
    /// controllers
    final TextEditingController emailLoginController = TextEditingController();
    final TextEditingController passwordLoginController =
        TextEditingController();

    /// form key
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    /// clear controllers
    void clearControllers() {
      emailLoginController.clear();
      passwordLoginController.clear();
    }

    return Consumer4<
      PageProvider,
      GoogleSignInProvider,
      EmailPasswordAuthProvider,
      InternetCheckerProvider
    >(
      builder: (
        context,
        pageProvider,
        googleSignInProvider,
        emailPasswordAuthProvider,
        internetCheckerProvider,
        child,
      ) {
        return Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// image
                  Stack(
                    children: [
                      /// Image Background
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18.r),
                        child: SizedBox(
                          height: 0.4.sh,
                          width: double.infinity,
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              pageProvider.changePage(index);
                            },
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(images[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      /// Content
                      Positioned(
                        bottom: 20.h,
                        left: 20.w,
                        right: 20.w,
                        child: Container(
                          height: 180.h,
                          width: 0.36.sw,
                          decoration: BoxDecoration(
                            color: AppColors.authContentBgColor.withOpacity(
                              0.8,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// Description
                                Text(
                                  descriptions[pageProvider.currentIndex],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.whiteColor,
                                  ),
                                ),

                                SizedBox(height: 30.h),

                                /// Smooth Page Indicator & Arrows
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    /// Smooth Page Indicator
                                    SmoothPageIndicator(
                                      controller: _pageController,
                                      count: images.length,
                                      effect: ExpandingDotsEffect(
                                        dotHeight: 4.h,
                                        dotWidth: 10.w,
                                        activeDotColor: Colors.white,
                                      ),
                                    ),

                                    /// Arrows
                                    Row(
                                      spacing: 14.w,
                                      children: [
                                        /// arrow backward
                                        AuthArrowContainer(
                                          icon: Icons.arrow_back,
                                          onTap: () {
                                            if (pageProvider.currentIndex > 0) {
                                              _pageController.previousPage(
                                                duration: Duration(
                                                  milliseconds: 300,
                                                ),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          },
                                        ),

                                        /// Arrow Forward
                                        AuthArrowContainer(
                                          icon: Icons.arrow_forward,
                                          onTap: () {
                                            if (pageProvider.currentIndex <
                                                images.length - 1) {
                                              _pageController.nextPage(
                                                duration: Duration(
                                                  milliseconds: 300,
                                                ),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.w),

                  /// email address text field
                  CustomTextField(
                    validator: AppValidator.validateEmail,
                    textEditingController: emailLoginController,
                    hintText: "Enter email address",
                    labelText: "Email Address",
                    prefixIcon: Icons.alternate_email,
                  ),

                  SizedBox(height: 20.h),

                  /// password text field
                  CustomTextField(
                    validator: AppValidator.validatePassword,
                    textEditingController: passwordLoginController,
                    hintText: "Enter password",
                    labelText: "Password",
                    prefixIcon: Icons.lock_outline,
                  ),

                  SizedBox(height: 20.h),

                  /// forget password text btn
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        /// auth forget password screen
                        GoRouter.of(context).pushNamed("authForgetPassword");
                      },
                      child: AutoSizeText(
                        minFontSize: 14,
                        "Forget Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// login btn
                  CustomIconFilledBtn(
                    isLoading: emailPasswordAuthProvider.isLoading,
                    onTap: () {
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
                        /// email login functionality
                        emailPasswordAuthProvider
                            .signInWithEmailPassword(
                              emailLoginController.text.trim(),
                              passwordLoginController.text.trim(),
                              context,
                            )
                            .then((_) async {
                              /// No need to check `if (value)` since it returns void
                              /// Save Auth Status in Hive
                              var box = Hive.box('userAuthStatusBox');
                              await box.put('userAuthStatus', true);

                              /// Navigate to home
                              GoRouter.of(context).pushReplacementNamed("home");

                              /// Clear controllers after everything is done
                              Future.delayed(Duration(milliseconds: 500), () {
                                clearControllers();
                              });
                            });
                      }
                    },
                    btnTitle: "Login",
                    iconPath: "login",
                    fontSize: 10.sp,
                  ),

                  SizedBox(height: 10.h),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        minFontSize: 14,
                        "Don't have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,
                          fontSize: 10.sp,
                        ),
                      ),

                      /// register text btn
                      TextButton(
                        onPressed: () {
                          /// sign up screen
                          GoRouter.of(context).pushNamed("authSignUp");
                        },
                        child: AutoSizeText(
                          minFontSize: 14,
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// divider
                  Row(
                    spacing: 4.w,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(color: AppColors.textFieldHintColor),
                      ),

                      AutoSizeText(
                        minFontSize: 14,
                        "Or",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textFieldHintColor,
                          fontSize: 10.sp,
                        ),
                      ),

                      Expanded(
                        child: Divider(color: AppColors.textFieldHintColor),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  CustomOutlinedIconBtn(
                    isLoading: googleSignInProvider.isLoading,
                    fontSize: 10.sp,
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

                      bool isSuccess = await googleSignInProvider
                          .signInWithGoogle(context);

                      if (isSuccess) {
                        /// No need to check `if (value)` since it returns void
                        /// Save Auth Status in Hive
                        var box = Hive.box('userAuthStatusBox');
                        await box.put('userAuthStatus', true);

                        /// Navigate to home
                        GoRouter.of(context).pushReplacementNamed("home");
                      } else {
                        ToastHelper.showErrorToast(
                          context: context,
                          message: "Failure in Google Auth",
                        );
                      }
                    },
                    btnTitle: "Sign In With Google",
                    iconPath: "google-auth",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
