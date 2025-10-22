import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/common_widgets/home_section_header.dart';
import 'package:tarkhineh/features/home/providers/food_controller.dart';

class SpecialFoods extends ConsumerWidget {
  const SpecialFoods({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(foodController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHomeSectionHeader(title: "منوی رستوران", isWhite: true),
        SizedBox(
          height: 300,
          child: ListView.builder(
            // TODO : item count
            itemCount: 1,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 18),
            itemBuilder: (BuildContext context, int index) {
              // TODO : create food item widget
              return;
            },
          ),
        ),
      ],
    );
  }
}
