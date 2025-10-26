import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/core/constants/color.dart';
import 'package:tarkhineh/core/extensions/price_format.dart';
import 'package:tarkhineh/core/models/food_model.dart';

class FoodItem extends ConsumerWidget {
  final FoodModel food;
  const FoodItem(this.food, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? newPrice = food.discountPercent != null
        ? (food.price * (1 - (food.discountPercent! / 100))).round()
        : null;

    return SizedBox(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // تصویر بالا
            AspectRatio(
              aspectRatio: 4 / 3,
              child: CachedNetworkImage(
                imageUrl: food.imageUrl,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(food.name, style: const TextStyle(fontSize: 16)),

                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            food.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: food.isFavorite ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          // قیمت قبلی خط خورده
                          if (newPrice != null)
                            Text(
                              food.price.toPersianFormat,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const SizedBox(width: 8),
                          // تخفیف درصد
                          if (food.discountPercent != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.pink.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "%${food.discountPercent}",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // قیمت جدید
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ستاره و عدد
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          Text(
                            food.star.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Text(
                        newPrice != null
                            ? newPrice.toPersianTomans
                            : food.price.toPersianTomans,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 6)),
                  // دکمه افزودن
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        // اضافه به سبد خرید
                      },
                      child: const Text(
                        "افزودن به سبد خرید",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
