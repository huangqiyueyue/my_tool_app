import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tool_app/state/providers/settings_provider.dart';

final themeProvider = Provider<ThemeMode>((ref) {
  final settings = ref.watch(settingsProvider);
  return settings.darkMode ? ThemeMode.dark : ThemeMode.light;
});
