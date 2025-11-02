import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/core/constants/color.dart';
import 'package:tarkhineh/core/extensions/price_format.dart';
import 'package:tarkhineh/core/models/food_model.dart';
import 'package:tarkhineh/core/theme.dart';

class FoodCard extends ConsumerWidget {
  final FoodModel food;
  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? newPrice = food.discountPercent != null
        ? (food.price * (1 - (food.discountPercent! / 100))).round()
        : null;

    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Image
          AspectRatio(
            aspectRatio: 14 / 16,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: food.imageUrl,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        food.name,
                        style: AppTheme.lightTheme.textTheme.bodyLarge,
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
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Text(
                          food.ingredients,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.lightTheme.textTheme.bodyMedium!
                              .copyWith(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      Text(
                        newPrice != null
                            ? newPrice.toPersianTomans
                            : food.price.toPersianTomans,
                        style: AppTheme.lightTheme.textTheme.bodyMedium!
                            .copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 40,
                        child: IconButton(
                          onPressed: () {},
                          icon: food.isFavorite
                              ? const Icon(
                                  CupertinoIcons.heart_fill,

                                  color: Colors.red,
                                )
                              : const Icon(CupertinoIcons.heart),
                        ),
                      ),
                      Expanded(
                        child: RatingBar.builder(
                          initialRating: food.star.toDouble(),
                          minRating: 1,
                          itemSize: 18,

                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemBuilder: (context, _) =>
                              const Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: (rating) {},
                        ),
                      ),

                      SizedBox(
                        height: 45,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "افزودن به سبد خرید",
                            style: AppTheme.lightTheme.textTheme.bodySmall!
                                .copyWith(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
