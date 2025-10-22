import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/common_widgets/no_connection_page.dart';
import 'package:tarkhineh/core/extensions/custom_snack_bar.dart';
import 'package:tarkhineh/core/network/connection_manager.dart';
import 'package:tarkhineh/core/theme.dart';
import 'package:tarkhineh/core/wrapper/global_result_notifier.dart';
import 'package:tarkhineh/core/wrapper/global_result_provider.dart';
import 'package:tarkhineh/service_locator.dart';
import 'core/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // وضعیت اتصال فعلی از Riverpod provider
    final connectionStatus = ref.watch(connectionProvider);
    final router = ref.watch(appRouterProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        title: 'رستوران های زنجیره ای ترخینه',
        builder: (context, child) {
          return ProviderListenerWrapper(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: connectionStatus == ConnectionStatus.disconnected ? const NoConnectionPage() : child!,
            ),
          );
        },
      ),
    );
  }
}

class ProviderListenerWrapper extends ConsumerWidget {
  final Widget child;
  const ProviderListenerWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<GlobalResult?>(globalResultProvider, (previous, next) {
      if (next == null || next.message == null) return;
      context.showSnackBar(next.message!, type: next.type);
    });

    return child;
  }
}
