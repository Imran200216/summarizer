import 'package:flutter/material.dart';
import 'package:summarize/features/datas/view/data_desktop_screen.dart';
import 'package:summarize/features/datas/view/data_mobile_screen.dart';
import 'package:summarize/features/datas/view/data_tablet_screen.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 1100) {
              return const DataDesktopScreen();
            } else if (constraints.maxWidth >= 650) {
              return const DataTabletScreen();
            } else {
              return const DataMobileScreen();
            }
          },
        ),
      ),
    );
  }
}
