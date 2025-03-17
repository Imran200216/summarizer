import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:summarize/commons/widgets/custom_icon_filled_btn.dart';
import 'package:summarize/commons/widgets/custom_text_area.dart';
import 'package:summarize/commons/widgets/custom_text_field.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:summarize/features/summarizer/view_modals/summarizer_text_provider.dart';

class SummarizerDesktopScreen extends StatelessWidget {
  const SummarizerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// current user
    final User? user = FirebaseAuth.instance.currentUser;

    return Consumer<SummarizerTextProvider>(
      builder: (context, summarizerTextProvider, child) {
        return Center(
          child: Stack(
            children: [
              /// Main Content - Wrapped in Align for Center Positioning
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 0.6.sh,
                  width: 0.4.sw,
                  padding: EdgeInsets.all(16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Greeting with User's Name (if available)
                        Text(
                          "Hi, ${user?.displayName ?? "User"}",
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

                        /// btn
                        summarizerTextProvider.hasText
                            ? Column(
                              children: [
                                SizedBox(height: 40.h),

                                /// Min words and Max words
                                Row(
                                  spacing: 20.w,
                                  children: [
                                    /// min length text field
                                    Expanded(
                                      child: CustomTextField(
                                        textEditingController:
                                            summarizerTextProvider
                                                .minLengthController,
                                        keyboardType: TextInputType.number,
                                        hintText: "Min Word",
                                        labelText: "Minimum word",
                                        prefixIcon: Icons.text_fields_sharp,
                                      ),
                                    ),

                                    /// max length text field
                                    Expanded(
                                      child: CustomTextField(
                                        textEditingController:
                                            summarizerTextProvider
                                                .maxLengthController,
                                        keyboardType: TextInputType.number,
                                        hintText: "Max Word",
                                        labelText: "Maximum word",
                                        prefixIcon: Icons.text_fields_sharp,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 40.h),

                                /// summarize btn
                                CustomIconFilledBtn(
                                  isLoading: summarizerTextProvider.isLoading,
                                  onTap: () async {
                                    await summarizerTextProvider
                                        .summarizeText();
                                  },
                                  btnTitle: "Summarize Quick Text",
                                  iconPath: "login",
                                  fontSize: 11.sp,
                                ),
                              ],
                            )
                            : SizedBox(),

                        /// summarizer text
                        summarizerTextProvider.summary.isEmpty
                            ? SizedBox()
                            : Column(
                              children: [
                                SizedBox(height: 40.h),
                                DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(10.r),
                                  dashPattern: [6, 4],
                                  color: AppColors.dottedBorder,
                                  strokeWidth: 1,
                                  child: Container(
                                    margin: EdgeInsets.all(12),
                                    width: 0.4.sw,
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// Speak Button
                                        GestureDetector(
                                          onTap: () {
                                            if (summarizerTextProvider
                                                .isSpeaking) {
                                              summarizerTextProvider
                                                  .stopSpeaking();
                                            } else {
                                              summarizerTextProvider
                                                  .speakSummary();
                                            }
                                          },
                                          child: Chip(
                                            label: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  summarizerTextProvider
                                                          .isSpeaking
                                                      ? Icons.stop
                                                      : Icons.mic,
                                                  color: AppColors.whiteColor,
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  summarizerTextProvider
                                                          .isSpeaking
                                                      ? "Stop"
                                                      : "Speak",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            backgroundColor:
                                                AppColors.primaryColor,
                                          ),
                                        ),

                                        SizedBox(height: 8.h),

                                        /// Summary Text
                                        Text(
                                          summarizerTextProvider.summary,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.subTitleColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                      ],
                    ),
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
