import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'config/env.dart';
import 'data/local/shared_prefs_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Future<void> _init() async {
  await SharedPrefsHelper.init();
  Env.init(isProduction: false);
}
