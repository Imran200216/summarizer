import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:summarize/features/datas/view_modals/summary_datas_provider.dart';
import 'package:summarize/features/datas/widgets/data_card.dart';

class DataTabletScreen extends StatefulWidget {
  const DataTabletScreen({super.key});

  @override
  State<DataTabletScreen> createState() => _DataTabletScreenState();
}

class _DataTabletScreenState extends State<DataTabletScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SummaryDataProvider>(
        context,
        listen: false,
      ).fetchUserSummaries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SummaryDataProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.summaries.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/svg/no-data.svg",
                  height: 0.4.sh,
                  width: 0.4.sw,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20.h),
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

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    provider.summaries.map((summary) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 10.w,
                        ),
                        child: SizedBox(
                          width: double.infinity,

                          child: DataCard(
                            inputData: summary['inputData'],
                            summaryData: summary['summarizedData'],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
