import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tarkhineh/features/auth/providers/auth_controller.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController textController;
  final AuthController controller;

  const OtpInput({super.key, required this.textController, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = PinTheme(
      width: 60,
      height: 60,
      textStyle: Theme.of(context).textTheme.headlineSmall,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 6,
        autofocus: true,
        controller: textController,
        defaultPinTheme: theme,
        focusedPinTheme: theme.copyWith(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
          ),
        ),
        submittedPinTheme: theme.copyWith(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            color: Colors.green.withValues(alpha: 0.1),
          ),
        ),
        onChanged: (value) => controller.updateOtp(value),
        keyboardType: TextInputType.number,
        onCompleted: (pin) {
          controller.verifyOtp();
        },
      ),
    );
  }
}
