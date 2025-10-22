import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tarkhineh/core/storage/secure_storage_service.dart';
import 'package:tarkhineh/features/auth/services/auth_service.dart';
import 'package:tarkhineh/service_locator.dart';

final authProvider = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController();
});

class AuthController extends ChangeNotifier {
  final authService = sl<IAuthService>();

  final loginformKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();

  bool isLoading = false;
  bool isEnable = false;
  bool agreed = false;
  bool isSuccess = false;
  bool isOtpSuccess = false;
  String message = "";

  // otp
  int secondsRemaining = 3;
  bool canResend = false;
  Timer? _timer;
  String otpCode = "";
  String resendText = "دریافت مجدد کد در 3 ثانیه";
  TextEditingController otpController = TextEditingController();

  void clearResult() {
    isOtpSuccess = false;
    isSuccess = false;
    message = "";
    notifyListeners();
  }

  void startTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 1) {
        secondsRemaining--;
        resendText = "دریافت مجدد کد در $secondsRemaining ثانیه";
        notifyListeners();
      } else {
        canResend = true;
        resendText = "دریافت مجدد کد";
        _timer?.cancel();
        notifyListeners();
      }
    });
  }

  void resendOtp() {
    if (!canResend) return;
    sendOtp();
    secondsRemaining = 3;
    canResend = false;
    resendText = "دریافت مجدد کد";

    startTimer();
  }

  String get phoneNumber => phoneController.text;

  Future<void> sendOtp() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final res = await authService.sendOtp(phoneNumber);
      isSuccess = res.success;
      message = res.message ?? "";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeCheckBox() {
    agreed = !agreed;
    canContinue();
    notifyListeners();
  }

  void updateText(String value) {
    canContinue();
    notifyListeners();
  }

  bool canContinue() {
    isEnable = agreed && (loginformKey.currentState?.validate() ?? false);
    return isEnable;
  }

  @override
  void dispose() {
    phoneController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفاً شماره موبایل را وارد کنید';
    }
    final regex = RegExp(r'^09\d{9}$');
    if (!regex.hasMatch(value)) {
      return 'شماره موبایل معتبر نیست';
    }
    return null;
  }

  void updateOtp(String value) {
    otpCode = value;
    notifyListeners();
  }

  final secureStorage = sl<SecureStorageService>();

  Future<void> verifyOtp() async {
    final res = await authService.verifyOtp(phoneNumber, otpCode);
    if (res.success) {
      isOtpSuccess = true;

      final accessToken = res.data!.accessToken;
      final refreshToken = res.data!.refreshToken;
      await secureStorage.saveJwt(accessToken, refreshToken);
    } else {
      isOtpSuccess = false;
      message = res.message ?? "";
    }

    notifyListeners();
  }
}
