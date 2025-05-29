import 'package:checkme/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screen/login_screen.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'CheckMe Todo',
      theme: theme,
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: const LoginScreen(),
    );
  }
}