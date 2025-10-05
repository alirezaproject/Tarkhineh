import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkhineh/features/auth/pages/login_page.dart';
import 'package:tarkhineh/startup/splash_page.dart';

import '../../features/onboarding/pages/onboarding_page.dart';

/// Provider برای Router
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', name: 'splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/onboarding', name: 'onboarding', builder: (context, state) => const OnboardingPage()),
      GoRoute(path: '/login', name: 'login', builder: (context, state) => const LoginPage()),
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
