import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:summarize/features/datas/view_modals/summary_datas_provider.dart';

class DataDesktopScreen extends StatefulWidget {
  const DataDesktopScreen({super.key});

  @override
  State<DataDesktopScreen> createState() => _DataDesktopScreenState();
}

class _DataDesktopScreenState extends State<DataDesktopScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SummaryDataProvider>(
      context,
      listen: false,
    ).fetchUserSummaries();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SummaryDataProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (provider.summaries.isEmpty) {
          return Center(
            child: Column(
              spacing: 20.h,
              children: [
                SvgPicture.asset(
                  "assets/images/svg/no-data.svg",
                  height: 150.h,
                  width: 150.w,
                  fit: BoxFit.cover,
                ),

                Text(
                  "No summaries found",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.subTitleColor,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: provider.summaries.length,
          itemBuilder: (context, index) {
            final summary = provider.summaries[index];
            return ListTile(
              leading: Icon(Icons.ac_unit, color: AppColors.primaryColor),
              title: Text(summary["inputData"]),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: AppColors.titleColor,
              ),
              subtitle: Text("Original: ${summary["summarizedData"]}"),
              subtitleTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
                color: AppColors.textFieldHintColor,
              ),
            );
          },
        );
      },
    );
  }
}
