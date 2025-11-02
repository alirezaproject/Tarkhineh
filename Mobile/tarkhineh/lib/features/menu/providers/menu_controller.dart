import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tarkhineh/core/extensions/custom_snack_bar.dart';
import 'package:tarkhineh/core/models/category_model.dart';
import 'package:tarkhineh/core/models/food_model.dart';
import 'package:tarkhineh/core/wrapper/global_result_provider.dart';
import 'package:tarkhineh/data/services/category_service.dart';
import 'package:tarkhineh/data/services/food_service.dart';
import 'package:tarkhineh/features/home/models/food_type_model.dart';
import 'package:tarkhineh/service_locator.dart';

/// Provider اصلی منو
final menuController =
    ChangeNotifierProvider.family<MenuController, FoodTypeModel>((
      ref,
      initialFoodType,
    ) {
      final controller = MenuController(ref);
      controller.initialize(initialFoodType);
      ref.onDispose(controller.dispose);
      return controller;
    });
    

class MenuController extends ChangeNotifier {
  final Ref ref;
  MenuController(this.ref);

  final categoryService = sl<ICategoryService>();
  final foodService = sl<IFoodService>();

  FoodTypeModel? selectedFoodType;
  CategoryModel? selectedCategory;

  final List<CategoryModel> _categoryModel = [];
  List<CategoryModel> get categoryModel => _categoryModel;

  final List<FoodModel> _foodModel = [];
  List<FoodModel> get foodModel => _foodModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// ===================== Initialization =====================
  Future<void> initialize(FoodTypeModel foodType) async {
    selectedFoodType = foodType;
    await fetchCategoriesAndFoods();
  }

  /// ===================== Selections =====================
  Future<void> selectFoodType(FoodTypeModel foodType) async {
    selectedFoodType = foodType;
    await fetchCategoriesAndFoods();
  }

  Future<void> selectCategory(CategoryModel category) async {
    selectedCategory = category;
    await fetchFoods();
  }

  /// ===================== API Calls =====================
  Future<void> fetchCategoriesAndFoods() async {
    await fetchCategories();
    if (selectedCategory != null) {
      await fetchFoods();
    }
  }

  Future<void> fetchCategories() async {
    if (selectedFoodType == null) return;
    await _runAsyncOperation(() async {
      final res = await categoryService.fetchCategories(selectedFoodType!.id);

      if (res.success && res.data != null) {
        _categoryModel
          ..clear()
          ..addAll(res.data!);

        selectedCategory = _categoryModel.isNotEmpty
            ? _categoryModel.first
            : null;
      } else {
        _showError('دسته‌بندی‌ها دریافت نشد.');
      }
    });
  }

  Future<void> fetchFoods() async {
    if (selectedCategory == null) return;
    await _runAsyncOperation(() async {
      final res = await foodService.getFoodsByCategoryId(selectedCategory!.id);

      if (res.success && res.data != null) {
        _foodModel
          ..clear()
          ..addAll(res.data!);
      } else {
        _showError('خطا در دریافت غذاها.');
      }
    });
  }

  /// ===================== Helpers =====================
  Future<void> _runAsyncOperation(Future<void> Function() operation) async {
    _isLoading = true;
    notifyListeners();
    try {
      await operation();
    } catch (_) {
      _showError('خطا در ارتباط با سرور');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _showError(String message) {
    ref
        .read(globalResultProvider.notifier)
        .showMessage(message, SnackBarType.error);
  }
}
