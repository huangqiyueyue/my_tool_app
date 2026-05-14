import 'package:flutter/material.dart';
import 'package:my_tool_app/ui/pages/home_page.dart';
import 'package:my_tool_app/ui/pages/detail_page.dart';
import 'package:my_tool_app/ui/pages/settings_page.dart';
import 'package:my_tool_app/ui/pages/splash_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/';
  static const String detail = '/detail';
  static const String settingsRoute = '/settings';
  
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case detail:
        final args = routeSettings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => DetailPage(itemId: args?['id'] ?? ''),
        );
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}
