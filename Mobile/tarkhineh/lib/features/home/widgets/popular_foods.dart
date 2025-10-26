import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tarkhineh/common_widgets/food_item.dart';
import 'package:tarkhineh/common_widgets/home_section_header.dart';
import 'package:tarkhineh/common_widgets/shimmer_food_item.dart';

import 'package:tarkhineh/features/home/providers/food_controller.dart';

class PopularFoods extends ConsumerWidget {
  const PopularFoods({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(foodController);

    final String title = "غذاهای  محبوب";

    if (controller.isLoading || controller.popularFoods.isEmpty) {
      return ShimmerFoodItem(
        title: title,
        isWhite: false,
        height: 300,
        width: 200,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHomeSectionHeader(title: title),
        SizedBox(
          height: 325,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              itemCount: controller.popularFoods.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 18),
              itemBuilder: (BuildContext context, int index) {
                final food = controller.popularFoods[index];
                return FoodItem(food);
              },
            ),
          ),
        ),
      ],
    );
  }
}
