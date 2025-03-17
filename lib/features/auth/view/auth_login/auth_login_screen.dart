import 'package:flutter/material.dart';
import 'package:summarize/features/auth/view/auth_login/auth_login_desktop_screen.dart';
import 'package:summarize/features/auth/view/auth_login/auth_login_mobile_screen.dart';
import 'package:summarize/features/auth/view/auth_login/auth_login_tablet_screen.dart';

class AuthLoginScreen extends StatelessWidget {
  const AuthLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Only dismiss when needed
        },
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: true,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 1100) {
                return AuthLoginDesktopScreen();
              } else if (constraints.maxWidth >= 650) {
                return AuthLoginTabletScreen();
              } else {
                return AuthLoginMobileScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
