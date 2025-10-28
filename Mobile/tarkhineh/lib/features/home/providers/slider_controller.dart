import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tarkhineh/core/extensions/custom_snack_bar.dart';
import 'package:tarkhineh/core/storage/secure_storage_service.dart';
import 'package:tarkhineh/core/wrapper/global_result_provider.dart';
import 'package:tarkhineh/features/home/models/slider_model.dart';
import 'package:tarkhineh/features/home/services/slider_service.dart';
import 'package:tarkhineh/service_locator.dart';

final sliderController = ChangeNotifierProvider<SliderController>((ref) {
  final controller = SliderController(ref);
  ref.onDispose(controller.dispose);
  controller.fetchSliders();
  return controller;
});

class SliderController extends ChangeNotifier {
  SliderController(this.ref);

  final Ref ref;

  final ISliderService sliderService = sl<ISliderService>();

  List<SliderModel> _sliders = [];
  List<SliderModel> get sliders => _sliders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int currentIndex = 0;

  final PageController pageController = PageController();
  final CarouselSliderController carouselController =
      CarouselSliderController();

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> clearToken() async {
    await sl<SecureStorageService>().clearTokens();
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
        ref
            .read(globalResultProvider.notifier)
            .showMessage('خطا در ارتباط با سرور', SnackBarType.error);
      }
    } catch (e) {
      ref
          .read(globalResultProvider.notifier)
          .showMessage('خطا در ارتباط با سرور:', SnackBarType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _sliders.clear();
    pageController.dispose();
    carouselController.stopAutoPlay();

    super.dispose();
  }
}
