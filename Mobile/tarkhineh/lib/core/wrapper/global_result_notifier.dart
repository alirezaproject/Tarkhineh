import 'package:flutter_riverpod/legacy.dart';
import 'package:tarkhineh/core/extensions/custom_snack_bar.dart';

class GlobalResult {
  final String? message;
  final SnackBarType type;
  final DateTime timestamp;

  GlobalResult({required this.message, required this.type}) : timestamp = DateTime.now();
}

class GlobalResultNotifier extends StateNotifier<GlobalResult?> {
  GlobalResultNotifier() : super(null);

  void showMessage(String message, SnackBarType type) {
    if (state?.message == message) return; // distinct
    state = GlobalResult(message: message, type: type);
  }

  void clear() => state = null;
}
