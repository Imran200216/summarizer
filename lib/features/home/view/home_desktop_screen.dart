import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:summarize/features/datas/view/data_screen.dart';
import 'package:summarize/features/home/view_modal/navigation_provider.dart';
import 'package:summarize/features/summarizer/view/summarizer_screen.dart';

class HomeDesktopScreen extends StatelessWidget {
  const HomeDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// providers
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: Row(
        children: [
          /// NavigationRail for desktop
          NavigationRail(
            indicatorColor: AppColors.primaryColor,
            selectedIndex: navigationProvider.selectedIndex,
            onDestinationSelected: (int index) {
              navigationProvider.setIndex(index);
            },
            labelType: NavigationRailLabelType.none,
            // Removed labels
            leading: SvgPicture.asset(
              "assets/icons/svg/summarizer-logo.svg",
              color: AppColors.primaryColor,
              height: 40.h,
              width: 40.w,
              fit: BoxFit.cover,
            ),
            trailing: const SizedBox(height: 20),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(
                  Icons.home_filled,
                  color: AppColors.whiteColor,
                ),
                label: SizedBox.shrink(), // Empty label
              ),

              NavigationRailDestination(
                icon: Icon(Icons.storage_outlined),
                selectedIcon: Icon(Icons.storage, color: AppColors.whiteColor),
                label: SizedBox.shrink(), // Empty label
              ),

              NavigationRailDestination(
                icon: Icon(Icons.logout_outlined),
                selectedIcon: Icon(Icons.logout, color: AppColors.whiteColor),
                label: SizedBox.shrink(), // Empty label
              ),
            ],
          ),

          /// Main content area
          Expanded(
            child: Center(
              child: _getSelectedScreen(
                navigationProvider.selectedIndex,
                context,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Function to return selected screen
  Widget _getSelectedScreen(int index, BuildContext context) {
    switch (index) {
      case 0:
        return SummarizerScreen();
      case 1:
        return DataScreen();
      case 2:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) {
              return Container();
            },
          );
        });
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }
}
