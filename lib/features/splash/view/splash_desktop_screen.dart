import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashDesktopScreen extends StatelessWidget {
  const SplashDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          "assets/icons/svg/summarizer-logo.svg",
          height: 120,
          width: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
