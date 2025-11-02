import 'package:flutter/material.dart';
import 'package:tarkhineh/core/constants/color.dart';
import 'package:tarkhineh/core/theme.dart';
import 'package:tarkhineh/features/home/models/food_type_model.dart';

class FoodTypeBar extends StatelessWidget {
  final List<FoodTypeModel> foodTypes;
  final FoodTypeModel selected;
  final ValueChanged<FoodTypeModel> onSelect;
  const FoodTypeBar({
    super.key,
    required this.foodTypes,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: foodTypes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (_, index) {
          final foodType = foodTypes[index];
          final isSelected = foodType.id == selected.id;

          return GestureDetector(
            onTap: () => onSelect(foodType),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? AppColor.primaryColor
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  foodType.name,
                  style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(
                    color: isSelected
                        ? AppColor.primaryColor
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
