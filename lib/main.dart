import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:summarize/core/router/app_router.dart';
import 'package:summarize/features/auth/view_modal/email_password_auth_provider.dart';
import 'package:summarize/features/auth/view_modal/google_sign_in_provider.dart';
import 'package:summarize/features/auth/view_modal/page_provider.dart';
import 'package:summarize/features/home/view_modal/navigation_provider.dart';
import 'package:summarize/features/summarizer/view_modals/summarizer_text_provider.dart';

import 'core/themes/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// hive
  await Hive.initFlutter();

  /// local storage for saving the user auth status
  await Hive.openBox("userAuthStatusBox");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// page provider
        ChangeNotifierProvider(create: (context) => PageProvider()),

        /// navigation provider
        ChangeNotifierProvider(create: (context) => NavigationProvider()),

        /// summarizer text provider
        ChangeNotifierProvider(create: (context) => SummarizerTextProvider()),

        /// google sign in provider
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),

        /// email password auth provider
        ChangeNotifierProvider(
          create: (context) => EmailPasswordAuthProvider(),
        ),
      ],
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: _getDesignSize(),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Summarizer',
              theme: ThemeData(
                textTheme: GoogleFonts.poppinsTextTheme(),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.primaryColor,
                ),
              ),
              routerConfig: AppRouter.router,
            );
          },
        );
      },
    );
  }

  /// Dynamically selects design size based on screen width
  Size _getDesignSize() {
    double screenWidth =
        WidgetsBinding
            .instance
            .platformDispatcher
            .views
            .first
            .physicalSize
            .width /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

    if (screenWidth >= 1024) {
      return const Size(1440, 900); // Desktop
    } else if (screenWidth >= 600) {
      return const Size(800, 1280); // Tablet
    } else {
      return const Size(360, 690); // mobile
    }
  }
}
