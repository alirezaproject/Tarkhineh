import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tarkhineh/core/theme.dart';

class WaveHeader extends StatelessWidget {
  final String title;
  final String description;
  final IconButton? icon;

  const WaveHeader({super.key, required this.title, required this.description, this.icon});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppTheme.lightTheme.primaryColor,
            padding: const EdgeInsets.only(top: 60, bottom: 150, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (icon != null) icon!,
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.moveTo(0, size.height - 15);

    double amplitude = 8; // ارتفاع کم برای دره‌ها
    double waveLength = size.width;

    for (double x = 0; x <= waveLength; x++) {
      double y = sin((x / waveLength) * 2 * pi) * amplitude;
      path.lineTo(x, size.height - 15 + y);
    }

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
