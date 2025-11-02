// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tarkhineh/core/extensions/custom_snack_bar.dart';
import 'package:tarkhineh/core/wrapper/global_result_provider.dart';

import 'package:tarkhineh/features/home/models/food_type_model.dart';
import 'package:tarkhineh/features/home/services/food_type_service.dart';
import 'package:tarkhineh/service_locator.dart';

final foodTypeController = ChangeNotifierProvider<FoodTypeController>((ref) {
  final controller = FoodTypeController(ref);

  ref.onDispose(controller.dispose);

  controller.fetchFoodTypes();
  return controller;
});

class FoodTypeController extends ChangeNotifier {
  Ref ref;
  final foodTypeService = sl<IFoodTypeService>();

  final List<FoodTypeModel> _foodTypes = [];
  List<FoodTypeModel> get foodTypes => _foodTypes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  FoodTypeController(this.ref);
  String? get errorMessage => _errorMessage;

  Future<void> fetchFoodTypes() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final res = await foodTypeService.getFoodTypes();

      if (res.success) {
        _foodTypes
          ..clear()
          ..addAll(res.data!);

        _errorMessage = null;
      } else {
        ref.read(globalResultProvider.notifier).showMessage('خطا در ارتباط با سرور', SnackBarType.error);
      }
    } catch (e) {
      ref.read(globalResultProvider.notifier).showMessage('خطا در ارتباط با سرور', SnackBarType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  FoodTypeModel? getFoodTypeById(String id) {
    try {
      return _foodTypes.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _foodTypes.clear();
    super.dispose();
  }
}
