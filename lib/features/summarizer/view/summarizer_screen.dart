import 'package:flutter/material.dart';
import 'package:summarize/features/summarizer/view/summarizer_desktop_screen.dart';
import 'package:summarize/features/summarizer/view/summarizer_mobile_screen.dart';
import 'package:summarize/features/summarizer/view/summarizer_tablet_screen.dart';

class SummarizerScreen extends StatelessWidget {
  const SummarizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 1100) {
              return const SummarizerDesktopScreen();
            } else if (constraints.maxWidth >= 650) {
              return const SummarizerTabletScreen();
            } else {
              return const SummarizerMobileScreen();
            }
          },
        ),
      ),
    );
  }
}
