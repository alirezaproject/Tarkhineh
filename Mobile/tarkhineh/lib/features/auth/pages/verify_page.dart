import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkhineh/common_widgets/loading.dart';
import 'package:tarkhineh/core/providers/global_error_provider.dart';
import 'package:tarkhineh/core/theme.dart';
import 'package:tarkhineh/features/auth/providers/auth_controller.dart';

import 'package:tarkhineh/features/auth/widgets/logo.dart';
import 'package:tarkhineh/features/auth/widgets/otp_input.dart';

class VerifyPage extends ConsumerWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final controller = ref.watch(authProvider);

    final notifier = ref.read(authProvider.notifier);

    //  final seconds = (controller.secondsRemaining % 60).toString().padLeft(2, '0');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.canResend) {
        notifier.startTimer();
      }
    });
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 75),
        child: GlobalResultListener(
          successMessage: (ctrl) => ctrl.message,
          onSuccessHandled: (_) {
            controller.clearResult();
          },
          replace: true,
          provider: authProvider,
          successCondition: (ctrl) => ctrl.isOtpSuccess,
          errorMessage: (ctrl) => ctrl.message,
          successRoute: "/home",
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppLogoWidget(size: 150, padding: EdgeInsets.symmetric(vertical: 75)),
                  Text('کد تایید', style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 24),
                  Text(
                    'کد تایید شش رقمی به شماره ${controller.phoneNumber} ارسال شد.',

                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 24),
                  OtpInput(controller: controller, textController: controller.otpController),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.watch_later_outlined, color: Color(0xFF2F6E4F), size: 22),
                          const SizedBox(width: 6),
                          if (!controller.canResend)
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontFamily: 'Estedad', fontSize: 15, color: Colors.black54),
                                children: [
                                  TextSpan(
                                    text: controller.resendText,
                                    style: const TextStyle(color: Color(0xFF2F6E4F)),
                                  ),
                                  //  const TextSpan(text: 'تا دریافت مجدد کد'),
                                ],
                              ),
                            )
                          else
                            GestureDetector(
                              onTap: controller.isLoading ? null : notifier.resendOtp,
                              child: const Text(
                                'ارسال مجدد کد',
                                style: TextStyle(fontFamily: 'Estedad', fontSize: 16, color: Color(0xFF2F6E4F), fontWeight: FontWeight.w600),
                              ),
                            ),
                        ],
                      ),
                      const Spacer(),
                      controller.isLoading
                          ? const AppLoading()
                          : TextButton(
                              onPressed: () {
                                controller.isSuccess = false;
                                controller.message = "";
                                controller.otpController.clear();
                                context.go('/login');
                              },
                              child: Text('ویرایش شماره', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.blue)),
                            ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  controller.isLoading
                      ? const AppLoading()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                          onPressed: controller.isEnable ? () async => await controller.verifyOtp() : null,
                          child: Text('ورود', style: AppTheme.lightTheme.textTheme.bodyLarge!.copyWith(color: Colors.white)),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
