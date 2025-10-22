import 'package:flutter_riverpod/legacy.dart';
import 'package:tarkhineh/core/wrapper/global_result_notifier.dart';

final globalResultProvider = StateNotifierProvider<GlobalResultNotifier, GlobalResult?>((ref) => GlobalResultNotifier());
