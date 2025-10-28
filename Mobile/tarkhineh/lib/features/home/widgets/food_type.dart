import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tarkhineh/common_widgets/home_section_header.dart';
import 'package:tarkhineh/core/theme.dart';
import 'package:tarkhineh/features/home/models/food_type_model.dart';
import 'package:tarkhineh/features/home/providers/food_type_controller.dart';

class AppFoodType extends ConsumerWidget {
  const AppFoodType({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(foodTypeController);

    return Builder(
      builder: (context) {
        if (controller.isLoading || controller.foodTypes.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHomeSectionHeader(title: "منوی رستوران"),
              Padding(
                padding: const EdgeInsets.only(right: 24, top: 25),
                child: Shimmer(
                  child: SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,

                      children: [
                        Container(
                          width: 125,
                          height: 125,
                          color: Colors.grey,
                          margin: const EdgeInsets.all(8),
                        ),
                        Container(
                          width: 125,
                          height: 125,
                          color: Colors.grey,
                          margin: const EdgeInsets.all(8),
                        ),
                        Container(
                          width: 125,
                          height: 125,
                          color: Colors.grey,
                          margin: const EdgeInsets.all(8),
                        ),
                        Container(
                          width: 125,
                          height: 125,
                          color: Colors.grey,
                          margin: const EdgeInsets.all(8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHomeSectionHeader(title: "منوی رستوران"),

              SizedBox(
                height: 210,

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(right: 18),
                    itemCount: controller.foodTypes.length,

                    itemBuilder: (context, index) {
                      final item = controller.foodTypes[index];
                      return _FoodTypeCard(item);
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class _FoodTypeCard extends StatelessWidget {
  final FoodTypeModel item;
  const _FoodTypeCard(this.item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ناوبری به صفحه منو با فیلتر نوع غذا
        context.push('/menu', extra: item);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SizedBox(
          width: 160,
          child: Stack(
            children: [
              Positioned(
                bottom: 25,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 150,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(blurRadius: 4)],
                    ),
                  ),
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    scale: 0.85,
                  ),
                ),
              ),

              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 0.5,
                          color: Colors.grey,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: Text(
                      item.name,
                      textAlign: TextAlign.center,
                      style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
