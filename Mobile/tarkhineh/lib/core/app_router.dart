import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkhineh/features/auth/pages/login_page.dart';
import 'package:tarkhineh/features/auth/pages/verify_page.dart';
import 'package:tarkhineh/features/home/pages/home_page.dart';
import 'package:tarkhineh/features/home/pages/main_layout.dart';
import 'package:tarkhineh/startup/splash_page.dart';

import '../features/onboarding/pages/onboarding_page.dart';

/// Provider برای Router
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', name: 'splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/onboarding', name: 'onboarding', builder: (context, state) => const OnboardingPage()),
      GoRoute(path: '/login', name: 'login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/verify', name: 'verify', builder: (context, state) => const VerifyPage()),

      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(path: '/home', builder: (_, __) => const HomePage()),

          //    GoRoute(path: '/menu', builder: (_, __) => const MenuPage()),
          //   GoRoute(path: '/orders', builder: (_, __) => const OrdersPage()),
          //GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
        ],
      ),
    ],
    // اگر Navigation وابسته به state بشه، اینجا می‌تونیم redirect اضافه کنیم:
    redirect: (context, state) {
      // مثال: اگر کاربر Onboarding رو کامل کرد بره Home
      // final completed = ref.read(onboardingControllerProvider).isCompleted;
      // if (completed && state.location == '/onboarding') return '/home';
      return null;
    },
  );
});
