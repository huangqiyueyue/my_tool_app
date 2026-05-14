import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tool_app/data/models/user_settings.dart';
import 'package:my_tool_app/services/storage_service.dart';

class SettingsNotifier extends StateNotifier<UserSettings> {
  SettingsNotifier() : super(const UserSettings()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final isDark = StorageService.getThemeMode();
    if (isDark != null) {
      state = state.copyWith(darkMode: isDark);
    }
  }

  void toggleTheme() {
    final newDarkMode = !state.darkMode;
    state = state.copyWith(darkMode: newDarkMode);
    StorageService.saveThemeMode(newDarkMode);
  }
}
