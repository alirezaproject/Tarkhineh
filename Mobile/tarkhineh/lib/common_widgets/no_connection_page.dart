import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/core/network/connection_manager.dart';

class NoConnectionPage extends ConsumerWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.read(connectionProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Color(0xFF2F6E4F)),
              const SizedBox(height: 20),
              const Text(
                'اتصال شما با آشپزخانه قطع شده است!',
                style: TextStyle(fontFamily: 'Estedad', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6E4F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                onPressed: () => manager.retryCheck(),
                child: const Text('تلاش دوباره', style: TextStyle(fontFamily: 'Estedad', fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
