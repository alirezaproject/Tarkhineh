import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/features/home/widgets/food_type.dart';
import 'package:tarkhineh/features/home/widgets/home_header.dart';
import 'package:tarkhineh/features/home/widgets/slider.dart';
import 'package:tarkhineh/features/home/widgets/special_foods.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              HomeHeader(), AppSlider(), AppFoodType(),
              //SpecialFoods(),
            ],
          ),
        ),
      ),
    );
  }
}
