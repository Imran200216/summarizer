import 'package:flutter/material.dart';
import 'package:summarize/features/home/view/home_desktop_screen.dart';
import 'package:summarize/features/home/view/home_mobile_screen.dart';
import 'package:summarize/features/home/view/home_tablet_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 1100) {
              return const HomeDesktopScreen();
            } else if (constraints.maxWidth >= 650) {
              return const HomeTabletScreen();
            } else {
              return const HomeMobileScreen();
            }
          },
        ),
      ),
    );
  }
}
