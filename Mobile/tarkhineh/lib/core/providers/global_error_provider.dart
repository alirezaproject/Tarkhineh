import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkhineh/core/extensions/custom_snack_bar.dart';

final globalErrorProvider = StateProvider<String?>((ref) => null);

class GlobalResultListener<T extends ChangeNotifier> extends ConsumerWidget {
  final ChangeNotifierProvider<T> provider;

  /// شرط موفقیت
  final bool Function(T) successCondition;

  /// پیام موفقیت
  final String? Function(T)? successMessage;

  /// پیام خطا
  final String? Function(T) errorMessage;

  final void Function(T)? onSuccessHandled;

  /// مسیر صفحه بعد
  final String? successRoute;

  /// حالت ناوبری
  final bool replace;

  /// UI اصلی
  final Widget child;

  const GlobalResultListener({
    super.key,
    required this.provider,
    required this.successCondition,
    this.successMessage,
    required this.errorMessage,
    this.successRoute,
    this.replace = true,
    required this.child,
    this.onSuccessHandled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.watch(provider);

    // موفقیت
    // داخل GlobalResultListener:
    if (successRoute != null && successCondition(ctrl)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final msg = successMessage?.call(ctrl);
        if (msg != null && msg.trim().isNotEmpty) {
          onSuccessHandled?.call(ctrl);
          context.showSnackBar(msg, type: SnackBarType.success);
        }

        if (replace) {
          context.go(successRoute!);
        } else {
          context.push(successRoute!);
        }
      });
    }

    final errMsg = errorMessage.call(ctrl);
    if (!successCondition(ctrl) && errMsg != null && errMsg.trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onSuccessHandled?.call(ctrl);
        context.showSnackBar(errMsg, type: SnackBarType.error);
        ref.read(globalErrorProvider.notifier).state = errMsg;
      });
    }

    return child;
  }
}
