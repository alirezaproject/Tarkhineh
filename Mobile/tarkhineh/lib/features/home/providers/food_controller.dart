// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tarkhineh/core/extensions/custom_snack_bar.dart';
import 'package:tarkhineh/core/models/food_model.dart';
import 'package:tarkhineh/core/wrapper/global_result_provider.dart';
import 'package:tarkhineh/features/home/services/food_service.dart';
import 'package:tarkhineh/service_locator.dart';

final foodController = ChangeNotifierProvider<FoodController>((ref) {
  final controller = FoodController(ref);
  ref.onDispose(controller.dispose);

  controller.fetchSpecialFoods();
  controller.fetchPopularsFoods();

  return controller;
});

class FoodController extends ChangeNotifier {
  final foodService = sl<IFoodService>();
  Ref ref;
  FoodController(this.ref);

  final List<FoodModel> _specialFoods = [];
  List<FoodModel> get specialFoods => _specialFoods;

  final List<FoodModel> _popularFoods = [];
  List<FoodModel> get popularFoods => _popularFoods;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchSpecialFoods() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final res = await foodService.getSpecialFoods();

      if (res.success) {
        _specialFoods
          ..clear()
          ..addAll(res.data!);

        _errorMessage = null;
      } else {
        ref
            .read(globalResultProvider.notifier)
            .showMessage('خطا در ارتباط با سرور', SnackBarType.error);
      }
    } catch (e) {
      ref
          .read(globalResultProvider.notifier)
          .showMessage('خطا در ارتباط با سرور', SnackBarType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPopularsFoods() async {
    try {
      final res = await foodService.getPopularFoods();

      if (res.success) {
        _popularFoods
          ..clear()
          ..addAll(res.data!);

        _errorMessage = null;
      } else {
        ref
            .read(globalResultProvider.notifier)
            .showMessage('خطا در ارتباط با سرور', SnackBarType.error);
      }
    } catch (e) {
      ref
          .read(globalResultProvider.notifier)
          .showMessage('خطا در ارتباط با سرور', SnackBarType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
