import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final loginControllerProvider = ChangeNotifierProvider<LoginController>((ref) {
  return LoginController();
});

class LoginController extends ChangeNotifier {
  final phoneController = TextEditingController();

  String _text = "";

  String get text => _text;


  bool isLoading = false;
  bool isEnable = false;
  bool agreed = false;

  Future<void> login(String phone) async {
    if (isLoading) return; // اگر در حال لودینگ هست، دوباره اجرا نشه

    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2), () {});

      // final request = LoginRequest(username: username, password: password);
      // final response = await read(authRepositoryProvider).login(request);
      // // ذخیره توکن در storage
      // read(appRouterProvider).go('/home');
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
    _text = value;
    canContinue();
    notifyListeners();
  }

  void clearText() {
    _text = "";
    notifyListeners();
  }

  bool canContinue() {
    if (text.isNotEmpty && text.length == 11 && agreed) {
      isEnable = true;
    } else {
      isEnable = false;
    }

    return isEnable;
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
