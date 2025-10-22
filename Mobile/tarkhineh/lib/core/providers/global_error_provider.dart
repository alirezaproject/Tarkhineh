import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkhineh/core/extensions/custom_snack_bar.dart';

final globalErrorProvider = StateProvider<String?>((ref) => null);

class GlobalResultListener<T extends ChangeNotifier> extends ConsumerStatefulWidget {
  final ChangeNotifierProvider<T> provider;
  final bool Function(T) successCondition;
  final String? Function(T)? successMessage;
  final String? Function(T) errorMessage;
  final void Function(T)? onSuccessHandled;
  final String? successRoute;
  final bool replace;
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
  ConsumerState<GlobalResultListener<T>> createState() => _GlobalResultListenerState<T>();
}

class _GlobalResultListenerState<T extends ChangeNotifier> extends ConsumerState<GlobalResultListener<T>> {
  String? _lastErrorMessage;
  String? _lastSuccessMessage;

  @override
  Widget build(BuildContext context) {
    final ctrl = ref.watch(widget.provider);
    final isSuccess = widget.successCondition(ctrl);
    final successMsg = widget.successMessage?.call(ctrl);
    final errorMsg = widget.errorMessage.call(ctrl);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isSuccess && successMsg != null && successMsg.trim().isNotEmpty && _lastSuccessMessage != successMsg) {
        context.showSnackBar(successMsg, type: SnackBarType.success);
        _lastSuccessMessage = successMsg;
        widget.onSuccessHandled?.call(ctrl);

        if (widget.successRoute != null) {
          widget.replace ? context.go(widget.successRoute!) : context.push(widget.successRoute!);
        }
      }

      if (!isSuccess && errorMsg != null && errorMsg.trim().isNotEmpty && _lastErrorMessage != errorMsg) {
        context.showSnackBar(errorMsg, type: SnackBarType.error);
        _lastErrorMessage = errorMsg;
        ref.read(globalErrorProvider.notifier).state = errorMsg;
      }
    });

    return widget.child;
  }
}
