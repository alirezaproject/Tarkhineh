import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarkhineh/core/theme.dart';
import '/core/routing/app_router.dart';

void main() {
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
