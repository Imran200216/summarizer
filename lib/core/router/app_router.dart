import 'package:go_router/go_router.dart';
import 'package:summarize/features/auth/view/auth_forget_password/auth_forget_password_screen.dart';
import 'package:summarize/features/auth/view/auth_login/auth_login_screen.dart';
import 'package:summarize/features/auth/view/auth_sign_up/auth_sign_up_screen.dart';
import 'package:summarize/features/datas/view/data_screen.dart';
import 'package:summarize/features/home/view/home_screen.dart';
import 'package:summarize/features/splash/view/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      /// Splash screen
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      /// Auth login screen
      GoRoute(
        path: '/authLogin',
        name: 'authLogin',
        builder: (context, state) => const AuthLoginScreen(),
      ),

      /// Auth sign-up screen
      GoRoute(
        path: '/authSignUp',
        name: 'authSignUp',
        builder: (context, state) => const AuthSignUpScreen(),
      ),

      /// Auth forget password screen
      GoRoute(
        path: '/authForgetPassword',
        name: 'authForgetPassword',
        builder: (context, state) => const AuthForgetPasswordScreen(),
      ),

      /// Home screen
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      /// data screen
      GoRoute(
        path: '/data',
        name: 'data',
        builder: (context, state) => const DataScreen(),
      ),
    ],
  );
}
