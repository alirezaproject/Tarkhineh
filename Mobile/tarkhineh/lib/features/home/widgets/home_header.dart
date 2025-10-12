import 'package:flutter/material.dart';
import 'package:tarkhineh/common_widgets/image.dart';
import 'package:tarkhineh/core/constants/assets.dart';
import 'package:tarkhineh/core/theme.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppTheme.lightTheme.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImage(path: AppAssets.logo, width: 100),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.location_on_outlined, color: Colors.white),
                Text("شعبه", style: AppTheme.lightTheme.textTheme.bodyLarge!.copyWith(color: Colors.white)),
                Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
