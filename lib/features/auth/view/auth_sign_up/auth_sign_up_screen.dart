import 'package:flutter/material.dart';
import 'package:summarize/features/auth/view/auth_sign_up/auth_sign_up_desktop_screen.dart';
import 'package:summarize/features/auth/view/auth_sign_up/auth_sign_up_mobile_screen.dart';
import 'package:summarize/features/auth/view/auth_sign_up/auth_sign_up_tablet_screen.dart';

class AuthSignUpScreen extends StatelessWidget {
  const AuthSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 1100) {
              return AuthSignUpDesktopScreen();
            } else if (constraints.maxWidth >= 650) {
              return AuthSignUpTabletScreen();
            } else {
              return AuthSignUpMobileScreen();
            }
          },
        ),
      ),
    );
  }
}
