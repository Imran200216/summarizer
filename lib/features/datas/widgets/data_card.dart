import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:summarize/core/themes/app_colors.dart';

class DataCard extends StatelessWidget {
  final String inputData;
  final String summaryData;

  const DataCard({
    super.key,
    required this.inputData,
    required this.summaryData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.textFieldHintColor, width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.w), // Adds padding inside ListTile
        leading: Icon(Icons.ac_unit, color: AppColors.primaryColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              inputData,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: AppColors.titleColor,
              ),
            ),
            SizedBox(height: 5.h), // Space between title and subtitle
          ],
        ),
        subtitle: Text(
          summaryData,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
            color: AppColors.textFieldHintColor,
          ),
        ),
      ),
    );
  }
}
