import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String path; // مسیر عکس (asset)
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Alignment alignment;
  final EdgeInsetsGeometry? margin;

  const AppImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.borderRadius,
    this.alignment = Alignment.center,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      margin: margin,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: Image.asset(path, width: width, height: height, fit: fit),
      ),
    );
  }
}
