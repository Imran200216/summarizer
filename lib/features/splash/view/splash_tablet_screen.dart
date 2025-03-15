import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashTabletScreen extends StatefulWidget {
  const SplashTabletScreen({super.key});

  @override
  State<SplashTabletScreen> createState() => _SplashTabletScreenState();
}

class _SplashTabletScreenState extends State<SplashTabletScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        "assets/icons/svg/summarizer-logo.svg",
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
