import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/core/theme.dart';
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
    final router = ref.watch(appRouterProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp.router(routerConfig: router, theme: AppTheme.lightTheme, debugShowCheckedModeBanner: false, title: 'Tarkhineh'),
    );
  }
}
