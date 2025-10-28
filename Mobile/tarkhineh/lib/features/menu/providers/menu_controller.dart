import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tarkhineh/features/home/models/food_type_model.dart';

final menuController = ChangeNotifierProvider<MenuController>((ref) {
  final controller = MenuController(ref);

  ref.onDispose(controller.dispose);
  return MenuController(ref);
});

class MenuController extends ChangeNotifier {
  final Ref ref;
  MenuController(this.ref);

  FoodTypeModel? selectedFoodType;

  void selectFoodType(FoodTypeModel foodType) {
    selectedFoodType = foodType;
    notifyListeners();
  }

}
