import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tool_app/ui/pages/home_page.dart';
import 'package:my_tool_app/ui/pages/settings_page.dart';
import 'package:my_tool_app/ui/pages/detail_page.dart';
import 'package:my_tool_app/ui/pages/splash_page.dart';
import 'package:my_tool_app/app/theme.dart';
import 'package:my_tool_app/app/routes.dart';
import 'package:my_tool_app/state/providers/theme_provider.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp(
      title: 'My Tool App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
