import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summarize/features/splash/view/splash_desktop_screen.dart';
import 'package:summarize/features/splash/view/splash_mobile_screen.dart';
import 'package:summarize/features/splash/view/splash_tablet_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAuth();
  }

  void _navigateToAuth() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        GoRouter.of(context).pushReplacementNamed("authLogin");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 1100) {
              return const SplashDesktopScreen();
            } else if (constraints.maxWidth >= 650) {
              return const SplashTabletScreen();
            } else {
              return const SplashMobileScreen();
            }
          },
        ),
      ),
    );
  }
}
