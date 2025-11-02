import 'package:flutter/material.dart';
import 'package:tarkhineh/core/models/category_model.dart';
import 'package:tarkhineh/core/theme.dart';

class MenuCategoryBar extends StatelessWidget {
  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel> onSelect;

  const MenuCategoryBar({
    super.key,
    required this.categories,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];

          return GestureDetector(
            onTap: () => onSelect(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  category.name,
                  style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(
                    color: Color(0xff353535),
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
