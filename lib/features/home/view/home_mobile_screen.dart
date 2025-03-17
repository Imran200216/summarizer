import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize/core/themes/app_colors.dart';
import 'package:summarize/features/datas/view/data_screen.dart';
import 'package:summarize/features/home/view_modal/navigation_provider.dart';
import 'package:summarize/features/profile/view/profile_screen.dart';
import 'package:summarize/features/summarizer/view/summarizer_screen.dart';

class HomeMobileScreen extends StatelessWidget {
  const HomeMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Provider to manage selected index
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: _getSelectedScreen(navigationProvider.selectedIndex, context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.selectedIndex,
        onTap: (index) {
          navigationProvider.setIndex(index);
        },
        backgroundColor: AppColors.primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage_outlined),
            label: "Data",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined),
            label: "Logout",
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
        return ProfileScreen();
      default:
        return const SizedBox();
    }
  }
}
