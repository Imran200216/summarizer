import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:summarize/core/themes/app_colors.dart';

class AuthArrowContainer extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const AuthArrowContainer({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 34.h,
        width: 34.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.blackColor,
          border: Border.all(color: AppColors.whiteColor, width: 0.5.w),
        ),
        child: Center(
          child: Icon(icon, color: AppColors.whiteColor, size: 14.w),
        ),
      ),
    );
  }
}
