import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tool_app/state/notifiers/settings_notifier.dart';
import 'package:my_tool_app/data/models/user_settings.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, UserSettings>((ref) {
  return SettingsNotifier();
});
