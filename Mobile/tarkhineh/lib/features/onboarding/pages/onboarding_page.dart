import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkhineh/features/onboarding/data/onboarding_data.dart';
import 'package:tarkhineh/features/onboarding/models/onboaring_model.dart';
import 'package:tarkhineh/features/onboarding/providers/onboarding_controller.dart';
import 'package:tarkhineh/features/onboarding/widgets/circular_indicator_button.dart';
import 'package:tarkhineh/features/onboarding/widgets/header.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                reverse: true,
                controller: controller.pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  controller.onPageChanged(index);
                },
                itemBuilder: (context, index) {
                  final item = onboardingData[index];
                  return OnboardingItemPage(item: item);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: AnimatedCircularIndicatorButton(
                targetProgress: (controller.currentIndex + 1) / onboardingData.length,
                onTap: () {
                  if (controller.currentIndex == 2) {
                    controller.closeOnboarding(context);
                    return;
                  } else {
                    controller.nextPage();
                  }
                },
                icon: controller.currentIndex == 2 ? Icons.check : Icons.chevron_left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingItemPage extends StatelessWidget {
  final OnboaringModel item;
  const OnboardingItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // هدر سبز موجی
        WaveHeader(
          title: item.title,
          description: item.description,
          icon: IconButton(
            onPressed: () {
              context.go('/login');
            },
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ),

        // تصویر
        Expanded(child: Center(child: Image.asset(item.image, height: 350))),
      ],
    );
  }
}
