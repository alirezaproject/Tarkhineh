import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/common_widgets/food_card.dart';
import 'package:tarkhineh/common_widgets/shimmer_food_card.dart';
import 'package:tarkhineh/core/theme.dart';
import 'package:tarkhineh/features/home/models/food_type_model.dart';
import 'package:tarkhineh/features/home/providers/food_type_controller.dart';
import 'package:tarkhineh/features/menu/providers/menu_controller.dart';
import 'package:tarkhineh/features/menu/widgets/food_type_bar.dart';
import 'package:tarkhineh/features/menu/widgets/menu_category_bar.dart';

class MenuPage extends ConsumerWidget {
  final FoodTypeModel initialFoodType;
  const MenuPage(this.initialFoodType, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(menuController(initialFoodType));
    final foodTypes = ref.watch(foodTypeController);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'منوی رستوران',
          style: AppTheme.lightTheme.textTheme.headlineMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(menuController);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoodTypeBar(
                    foodTypes: foodTypes.foodTypes,
                    selected: controller.selectedFoodType ?? initialFoodType,
                    onSelect: (f) => ref
                        .read(menuController(initialFoodType))
                        .selectFoodType(f),
                  ),
                  const SizedBox(height: 16),
                  MenuCategoryBar(
                    categories: controller.categoryModel,
                    onSelect: (value) => ref
                        .read(menuController(initialFoodType))
                        .selectCategory(value),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      controller.selectedCategory?.name ?? '',
                      style: AppTheme.lightTheme.textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Builder(
                      builder: (context) {
                        if (controller.isLoading) {
                          return ShimmerFoodCard();
                        } else {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.foodModel.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                      
                              final food = controller.foodModel[index];
                              return FoodCard(food: food);
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
