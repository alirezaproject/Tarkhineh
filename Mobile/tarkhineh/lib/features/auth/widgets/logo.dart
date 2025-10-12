import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  final double size; // سایز مجاز برای لوگو
  final Color? backgroundColor; // رنگ بک‌گراند قابل تنظیم
  final Color color; // رنگ بک‌گراند قابل تنظیم
  final EdgeInsets padding; // فاصله داخلی

  const AppLogoWidget({
    super.key,
    this.size = 120,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(8.0),
    this.color = const Color(0xFF417F56),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(color: backgroundColor ?? Colors.transparent, shape: BoxShape.circle),
      child: Image.asset(
        'assets/images/logo_vector.png', // مسیر لوگو
        width: size,
        height: size,
        fit: BoxFit.contain,
        color: color,
      ),
    );
  }
}
