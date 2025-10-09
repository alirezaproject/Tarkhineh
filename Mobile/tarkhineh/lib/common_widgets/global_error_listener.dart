import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/core/providers/global_error_provider.dart';
import 'package:tarkhineh/core/theme.dart';

class GlobalErrorListener extends ConsumerWidget {
  final Widget child;
  const GlobalErrorListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<String?>(globalErrorProvider, (prev, next) {
      if (next != null && next.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: AppTheme.lightTheme.textTheme.bodyLarge!.fontFamily),
            ),
            backgroundColor: Colors.red.shade700,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(globalErrorProvider.notifier).state = null;
      }
    });

    return child;
  }
}
