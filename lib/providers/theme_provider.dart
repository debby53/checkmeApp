import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final themeProvider = Provider<ThemeData>((ref) {
  final mode = ref.watch(themeModeProvider);
  return mode == ThemeMode.dark ? ThemeData.dark() : ThemeData.light();
});