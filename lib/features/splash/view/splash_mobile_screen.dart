import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashMobileScreen extends StatefulWidget {
  const SplashMobileScreen({super.key});

  @override
  State<SplashMobileScreen> createState() => _SplashMobileScreenState();
}

class _SplashMobileScreenState extends State<SplashMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        "assets/icons/svg/summarizer-logo.svg",
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
