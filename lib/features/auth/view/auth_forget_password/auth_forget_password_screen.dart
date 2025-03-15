import 'package:flutter/material.dart';
import 'package:summarize/features/auth/view/auth_login/auth_login_desktop_screen.dart';
import 'package:summarize/features/auth/view/auth_login/auth_login_mobile_screen.dart';
import 'package:summarize/features/auth/view/auth_login/auth_login_tablet_screen.dart';

class AuthForgetPasswordScreen extends StatelessWidget {
  const AuthForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 1100) {
              return AuthLoginDesktopScreen();
            } else if (constraints.maxWidth >= 650) {
              return const AuthLoginTabletScreen();
            } else {
              return const AuthLoginMobileScreen();
            }
          },
        ),
      ),
    );
  }
}
