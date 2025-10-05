import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/common_widgets/loading.dart';
import 'package:tarkhineh/common_widgets/text_field.dart';
import 'package:tarkhineh/core/theme.dart';
import 'package:tarkhineh/features/auth/providers/login_controller.dart';
import 'package:tarkhineh/features/auth/widgets/logo.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(loginControllerProvider);

    final currentText = ref.watch(loginControllerProvider).text;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            AppLogoWidget(size: 150, padding: EdgeInsets.symmetric(vertical: 75)),
            Text('ورود / ثبت نام', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 24),
            Text('.شماره همراه خود را وارد کنید', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.blueGrey)),
            const SizedBox(height: 24),
            ValueListenableBuilder(
              valueListenable: ref.read(loginControllerProvider).phoneController,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return AppTextField(
                  controller: ref.read(loginControllerProvider).phoneController,
                  label: "شماره همراه",
                  onChanged: (value) => ref.read(loginControllerProvider).updateText(value),
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                );
              },
            ),

            const SizedBox(height: 24),

            controller.isLoading
                ? const AppLoading()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                    onPressed: controller.isEnable ? () async => await controller.login(controller.phoneController.text) : null,
                    child: const Text('ارسال کد', style: TextStyle(fontFamily: "Estedad")),
                  ),
                  
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    style: const TextStyle(fontFamily: "Estedad", fontSize: 12, color: Colors.black),
                    children: [
                      const TextSpan(text: "من  "),
                      TextSpan(
                        text: " قوانین و مقررات",
                        style: TextStyle(
                          fontFamily: "Estedad",
                          fontSize: 14,
                          color: AppTheme.lightTheme.primaryColor, // سبز برند
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: "  ارائه خدمات توسط ترخینه را می‌پذیرم."),
                    ],
                  ),
                ),
                Checkbox(
                  value: controller.agreed,
                  activeColor: const Color(0xFF2F6E4F), // رنگ سبز برند
                  onChanged: (bool? value) {
                    controller.changeCheckBox();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
