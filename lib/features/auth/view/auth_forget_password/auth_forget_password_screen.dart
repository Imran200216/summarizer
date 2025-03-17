import 'package:flutter/material.dart';
import 'package:summarize/features/auth/view/auth_forget_password/auth_forget_password_desktop_screen.dart';
import 'package:summarize/features/auth/view/auth_forget_password/auth_forget_password_mobile_screen.dart';
import 'package:summarize/features/auth/view/auth_forget_password/auth_forget_password_tablet_screen.dart';

class AuthForgetPasswordScreen extends StatelessWidget {
  const AuthForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 1100) {
              return AuthForgetPasswordDesktopScreen();
            } else if (constraints.maxWidth >= 650) {
              return const AuthForgetPasswordTabletScreen();
            } else {
              return const AuthForgetPasswordMobileScreen();
            }
          },
        ),
      ),
    );
  }
}
