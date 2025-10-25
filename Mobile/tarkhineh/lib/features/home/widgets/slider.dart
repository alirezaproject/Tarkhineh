import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tarkhineh/core/constants/assets.dart';
import 'package:tarkhineh/core/theme.dart';
import 'package:tarkhineh/features/home/providers/slider_controller.dart';

class AppSlider extends ConsumerStatefulWidget {
  const AppSlider({super.key});

  @override
  ConsumerState<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends ConsumerState<AppSlider> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(sliderProvider);

    if (controller.isLoading || controller.sliders.isEmpty) {
      return Shimmer(child: Container(height: 220, color: Colors.grey));
    }

    return GestureDetector(
      onLongPress: () {
        controller.clearToken();
      },
      child: Stack(
        children: [
          
          CarouselSlider.builder(
            carouselController: controller.carouselController,
            itemCount: controller.sliders.length,
            itemBuilder: (context, index, realIndex) {
              final slider = controller.sliders[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  
                  CachedNetworkImage(
                    imageUrl: slider.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 220,
                    placeholder: (context, url) => Shimmer(child: Container(height: 220, color: Colors.grey)),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
      
                  Container(color: Colors.black.withValues(alpha: 0.5)),
      
                  // centered title text
                  Center(
                    child: Text(
                      slider.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(offset: Offset(1, 1), blurRadius: 3, color: Colors.black54)],
                      ),
                    ),
                  ),
                ],
              );
            },
            options: CarouselOptions(
              height: 200,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                ref.read(sliderProvider.notifier).setCurrentIndex(index);
              },
            ),
          ),
      
          // 👇 fixed indicator overlaid on image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppAssets.sliderBackground), fit: BoxFit.cover),
                ),
                child: AnimatedSmoothIndicator(
                  activeIndex: controller.currentIndex,
                  count: controller.sliders.length,
      
                  effect: JumpingDotEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    spacing: 6,
                    dotColor: Colors.grey.withValues(alpha: 0.4),
                    activeDotColor: AppTheme.lightTheme.primaryColor,
                    strokeWidth: 1,
                  ),
                  onDotClicked: (index) {
                    controller.carouselController.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
