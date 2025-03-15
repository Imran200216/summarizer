import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:summarize/commons/widgets/custom_icon_filled_btn.dart';
import 'package:summarize/commons/widgets/custom_outlined_btn.dart';
import 'package:summarize/commons/widgets/custom_text_field.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:summarize/features/auth/view/widgets/auth_arrow_container.dart';
import 'package:summarize/features/auth/view_modal/page_provider.dart';

class AuthLoginDesktopScreen extends StatelessWidget {
  AuthLoginDesktopScreen({super.key});

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
    return ChangeNotifierProvider(
      create: (context) => PageProvider(),
      child: Consumer<PageProvider>(
        builder: (context, pageProvider, child) {
          return Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    /// Image Background
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),
                      child: SizedBox(
                        height: 0.84.sh,
                        width: 0.4.sw,
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
                          color: AppColors.authContentBgColor.withOpacity(0.8),
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
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: AutoSizeText(
                                  minFontSize: 14,
                                  descriptions[pageProvider.currentIndex],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.spMin,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.whiteColor,
                                  ),
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
                                      dotHeight: 8.h,
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

                SizedBox(width: 40.w),

                /// Content Placeholder
                Container(
                  height: 0.84.sh,
                  width: 0.4.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 30.h,
                      bottom: 50.h,
                      right: 40.h,
                      left: 40.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// title
                        AutoSizeText(
                          minFontSize: 12,
                          "Login to your account",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.titleColor,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 6.h),

                        /// description
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.w),
                          child: AutoSizeText(
                            minFontSize: 8,
                            textAlign: TextAlign.center,
                            "Access your account to stay connected, manage your tasks, and chat seamlessly. Secure and effortless login for a smooth experience.",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.subTitleColor,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),

                        SizedBox(height: 60.h),

                        /// email address
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.w),
                          child: CustomTextField(
                            hintText: "Enter email address",
                            labelText: "Email Address",
                            prefixIcon: Icons.alternate_email,
                          ),
                        ),

                        SizedBox(height: 40.h),

                        /// password
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.w),
                          child: CustomTextField(
                            hintText: "Enter password",
                            labelText: "Password",
                            prefixIcon: Icons.lock_outline,
                          ),
                        ),

                        SizedBox(height: 20.h),

                        /// forget password text btn
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 40.w),
                            child: TextButton(
                              onPressed: () {
                                /// auth forget password screen
                                GoRouter.of(
                                  context,
                                ).pushNamed("authForgetPassword");
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
                        ),

                        Spacer(),

                        /// login btn
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.w),
                          child: CustomIconFilledBtn(
                            onTap: () {},
                            btnTitle: "Login",
                            iconPath: "login",
                            fontSize: 10.sp,
                          ),
                        ),

                        SizedBox(height: 20.h),

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

                            TextButton(
                              onPressed: () {
                                /// auth sign up
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

                        SizedBox(height: 20.h),

                        /// divider
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Row(
                            spacing: 4.w,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColors.textFieldHintColor,
                                ),
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
                                child: Divider(
                                  color: AppColors.textFieldHintColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        /// google login btn
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.w),
                          child: CustomOutlinedIconBtn(
                            fontSize: 10.sp,
                            onTap: () {},
                            btnTitle: "Sign In With Google",
                            iconPath: "google-auth",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
