import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkhineh/core/storage/secure_storage_service.dart';
import 'package:tarkhineh/features/auth/pages/login_page.dart';
import 'package:tarkhineh/features/auth/pages/verify_page.dart';
import 'package:tarkhineh/features/home/pages/home_page.dart';
import 'package:tarkhineh/service_locator.dart';
import 'package:tarkhineh/startup/splash_page.dart';

import '../features/onboarding/pages/onboarding_page.dart';

/// Provider برای Router
final appRouterProvider = Provider<GoRouter>((ref) {
  final storage = sl<SecureStorageService>();
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', name: 'splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/onboarding', name: 'onboarding', builder: (context, state) => const OnboardingPage()),
      GoRoute(path: '/login', name: 'login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/verify', name: 'verify', builder: (context, state) => const VerifyPage()),
      GoRoute(path: '/home', name: 'home', builder: (context, state) => const HomePage()),
    ],
    // اگر Navigation وابسته به state بشه، اینجا می‌تونیم redirect اضافه کنیم:
    redirect: (context, state) async {
      final isLoggedIn = await storage.getJwt() != null;
      if (isLoggedIn) {
        return '/home';
      }
      // مثال: اگر کاربر Onboarding رو کامل کرد بره Home
      // final completed = ref.read(onboardingControllerProvider).isCompleted;
      // if (completed && state.location == '/onboarding') return '/home';
      return null;
    },
  );
});
