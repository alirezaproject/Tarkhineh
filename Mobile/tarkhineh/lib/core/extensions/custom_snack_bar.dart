import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

extension SnackBarExtensions on BuildContext {
  void showSnackBar(String message, {SnackBarType type = SnackBarType.info, Duration duration = const Duration(seconds: 3)}) {
    // رنگ‌ها و استایل‌ها رو بر اساس نوع تعیین می‌کنیم
    Color backgroundColor;
    IconData icon;
    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green.shade600;
        icon = Icons.check_circle;
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red.shade700;
        icon = Icons.error;
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.orange.shade800;
        icon = Icons.warning;
        break;
      case SnackBarType.info:
        backgroundColor = Colors.blue.shade600;
        icon = Icons.info;
    }

    // ساخت خود SnackBar
    final snackBar = SnackBar(
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
