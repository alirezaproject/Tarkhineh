// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final foodController = ChangeNotifierProvider<FoodController>((ref) {
  final controller = FoodController(ref);
  ref.onDispose(controller.dispose);

  controller.fetchSpecialFoods();

  return controller;
});

class FoodController extends ChangeNotifier {
  Ref ref;
  FoodController(this.ref);

  // TODO : Create List Viewmodel and write backend

  Future<void> fetchSpecialFoods() async {}
}
