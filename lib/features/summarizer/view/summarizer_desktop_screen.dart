import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:summarize/commons/widgets/custom_icon_filled_btn.dart';
import 'package:summarize/commons/widgets/custom_text_area.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:summarize/features/summarizer/view_modals/summarizer_text_provider.dart';

class SummarizerDesktopScreen extends StatelessWidget {
  const SummarizerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SummarizerTextProvider>(
      builder: (context, summarizerTextProvider, child) {
        return Center(
          child: Stack(
            children: [
              /// Profile section at top-right
              Positioned(
                top: 16.h,
                right: 16.w,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w, top: 16.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Profile Photo
                      CircleAvatar(
                        radius: 20.r,
                        backgroundImage: NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1671656349322-41de944d259b?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        ),
                      ),
                      SizedBox(width: 8.w),

                      /// Email Address
                      Text(
                        "imran@gmail.com",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.subTitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Main Content - Wrapped in Align for Center Positioning
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 0.6.sh,
                  width: 0.4.sw,
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Greeting
                      Text(
                        "Hi, Imran B",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.titleColor,
                          fontSize: 20.sp,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// Description
                      Text(
                        "Summarize your text effortlessly! Paste a paragraph, and get a concise and clear summary in seconds.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.subTitleColor,
                          fontSize: 14.sp,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      /// Text Area for Summarizing
                      CustomTextArea(
                        textEditingController:
                            summarizerTextProvider.textController,
                        hintText: "Enter paragraph to summarize",
                        labelText: "Enter para",
                      ),

                      summarizerTextProvider.hasText
                          ? Column(
                            children: [
                              SizedBox(height: 40.h),
                              CustomIconFilledBtn(
                                onTap: () {},
                                btnTitle: "Summarize Quick Text",
                                iconPath: "login",
                                fontSize: 14.sp,
                              ),
                            ],
                          )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
