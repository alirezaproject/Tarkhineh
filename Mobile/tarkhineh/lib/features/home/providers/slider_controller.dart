import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tarkhineh/features/home/models/slider_model.dart';
import 'package:tarkhineh/features/home/services/slider_service.dart';
import 'package:tarkhineh/service_locator.dart';

final sliderProvider = ChangeNotifierProvider<SliderController>((ref) {
  final controller = SliderController();

  ref.onDispose(controller.dispose);

  controller.fetchSliders();
  return controller;
});

class SliderController extends ChangeNotifier {
  final ISliderService sliderService = sl<ISliderService>();

  List<SliderModel> _sliders = [];
  List<SliderModel> get sliders => _sliders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int currentIndex = 0;

  final PageController pageController = PageController();
  final CarouselSliderController carouselController = CarouselSliderController();

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> fetchSliders({bool forceRefresh = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final res = await sliderService.getSliders();

      if (res.success) {
        if (forceRefresh) {
          _sliders = res.data!;
        } else {
          _sliders
            ..clear()
            ..addAll(res.data!);
        }
        _errorMessage = null;
      } else {
        _errorMessage = res.message ?? 'خطای نامشخص در دریافت اسلایدرها';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _sliders.clear();
    super.dispose();
  }
}
