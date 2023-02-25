import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/bootstrap.dart';
import 'package:taskify/shared/router.dart';
import 'shared/app_theme.dart';

void main() async {
  final container = await bootstrap();
  runApp(
    ProviderScope(
      parent: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final theme = ref.watch(themeProvider);
        final mode = ref.watch(themeModeProvider);
        return MaterialApp.router(
          routerConfig: router,
          title: 'Taskify',
          debugShowCheckedModeBanner: false,
          theme: theme.lightTheme,
          darkTheme: theme.darkTheme,
          themeMode: mode,
        );
      },
    );
  }
}
