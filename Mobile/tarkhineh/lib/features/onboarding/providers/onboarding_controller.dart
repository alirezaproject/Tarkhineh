import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

class OnboardingController extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentIndex = 0;

  int get totalPages => 3; // تعداد کل صفحات onboarding

  void onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (currentIndex < totalPages - 1) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void prevPage() {
    if (currentIndex > 0) {
      pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void closeOnboarding(BuildContext context) {
    context.go('/login');
  }
}

// Provider از نوع ChangeNotifier
final onboardingControllerProvider = ChangeNotifierProvider<OnboardingController>((ref) {
  return OnboardingController();
});
