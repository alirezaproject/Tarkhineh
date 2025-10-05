import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tarkhineh/core/constants/assets.dart';
import 'package:tarkhineh/core/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int activeIndex = 0;
  final int dotCount = 3;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        // اگر آخرین نقطه بود مستقیماً برگرد به اول
        if (activeIndex == dotCount - 1) {
          activeIndex = 0;
        } else {
          activeIndex++;
        }
      });
    });

    // تایمر کوتاه برای حرکت به صفحه بعدی
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return; // چک کنیم که ویجت هنوز زنده است

      context.go('/onboarding');
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppAssets.splashBackground, fit: BoxFit.cover)),
          Center(child: Image.asset(AppAssets.logo, width: 180, fit: BoxFit.contain)),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                duration: Duration.zero,
                count: dotCount,
                effect: ScaleEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.white,
                  dotColor: Colors.white54,
                  scale: 1.6, // بزرگ‌ترین حالت نقطه فعال
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
