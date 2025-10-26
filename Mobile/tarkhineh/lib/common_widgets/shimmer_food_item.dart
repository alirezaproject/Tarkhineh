// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:tarkhineh/common_widgets/home_section_header.dart';

class ShimmerFoodItem extends StatelessWidget {
  final String title;
  final bool isWhite;
  final double height;
  final double width;

  const ShimmerFoodItem({
    super.key,
    required this.title,
    required this.isWhite,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHomeSectionHeader(title: title, isWhite: isWhite),
        Shimmer(
          child: SizedBox(
            height: height,

            child: ListView(
              scrollDirection: Axis.horizontal,

              children: List.generate(
                5,
                (index) => Container(
                  width: width,

                  color: Colors.grey,
                  margin: const EdgeInsets.all(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
