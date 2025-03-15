import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:summarize/core/themes/app_colors.dart';

class CustomOutlinedIconBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String btnTitle;
  final bool isLoading;
  final String iconPath;
  final double fontSize;

  const CustomOutlinedIconBtn({
    super.key,
    required this.onTap,
    required this.btnTitle,
    this.isLoading = false,
    required this.iconPath,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          isLoading
              ? null
              : () {
                onTap();
              }, // Disable tap when loading
      child: Container(
        height: 38.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(width: 1, color: AppColors.textFieldHintColor),
          color:
              isLoading
                  // ignore: deprecated_member_use
                  ? AppColors.transparentColor
                  : AppColors.transparentColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isLoading)
              SvgPicture.asset(
                "assets/icons/svg/$iconPath.svg",
                height: 17.w,
                width: 17.w,
              ),
            if (!isLoading) SizedBox(width: 10.w),
            // Add spacing between icon and text
            isLoading
                ? SizedBox(
                  height: 20.w,
                  width: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                )
                : Text(
                  btnTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleColor,
                    fontSize: fontSize,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
