import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/common_widgets/food_item.dart';
import 'package:tarkhineh/common_widgets/home_section_header.dart';
import 'package:tarkhineh/common_widgets/shimmer_food_item.dart';
import 'package:tarkhineh/core/constants/color.dart';
import 'package:tarkhineh/features/home/providers/food_controller.dart';

class SpecialFoods extends ConsumerWidget {
  const SpecialFoods({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(foodController);

    final String title = " پیشنهاد  ویژه   ";

    if (controller.isLoading || controller.specialFoods.isEmpty) {
      return ShimmerFoodItem(
        title: title,
        isWhite: true,
        height: 300,
        width: 200,
      );
    }

    return Container(
      color: AppColor.secondaryBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHomeSectionHeader(title: title, isWhite: true),
          SizedBox(
            height: 325,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ListView.builder(
                itemCount: controller.specialFoods.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 18),
                itemBuilder: (BuildContext context, int index) {
                  final food = controller.specialFoods[index];
                  return FoodItem(food);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
