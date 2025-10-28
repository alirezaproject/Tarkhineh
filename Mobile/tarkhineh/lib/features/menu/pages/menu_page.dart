import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/core/constants/color.dart';
import 'package:tarkhineh/core/theme.dart';
import 'package:tarkhineh/features/home/models/food_type_model.dart';
import 'package:tarkhineh/features/home/providers/food_type_controller.dart';
import 'package:tarkhineh/features/menu/providers/menu_controller.dart';

class MenuPage extends ConsumerStatefulWidget {
  final FoodTypeModel initialFoodType;
  const MenuPage(this.initialFoodType, {super.key});

  @override
  ConsumerState<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(menuController.notifier).selectFoodType(widget.initialFoodType);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedFoodType = ref.watch(menuController).selectedFoodType;
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
              //     await ref.refresh(foodTypeController.future);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _FoodTypeBar(
                    foodTypes: foodTypes.foodTypes,
                    selected: selectedFoodType ?? foodTypes.foodTypes.first,
                    onSelect: (f) =>
                        ref.read(menuController.notifier).selectFoodType(f),
                  ),
                  // 🥘 اینجا بعداً لیست آیتم‌های منو رو اضافه کن
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FoodTypeBar extends StatelessWidget {
  final List<FoodTypeModel> foodTypes;
  final FoodTypeModel selected;
  final ValueChanged<FoodTypeModel> onSelect;

  const _FoodTypeBar({
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
