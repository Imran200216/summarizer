import 'package:flutter/material.dart';
import 'package:summarize/features/profile/view/profile_desktop_screen.dart';
import 'package:summarize/features/profile/view/profile_mobile_screen.dart';
import 'package:summarize/features/profile/view/profile_tablet_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 1100) {
              return const ProfileDesktopScreen();
            } else if (constraints.maxWidth >= 650) {
              return const ProfileTabletScreen();
            } else {
              return const ProfileMobileScreen();
            }
          },
        ),
      ),
    );
  }
}
