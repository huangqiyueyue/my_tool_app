import 'package:my_tool_app/data/local/shared_prefs_helper.dart';
import 'package:my_tool_app/core/constants/storage_keys.dart';

class StorageService {
  static Future<void> saveThemeMode(bool isDark) async {
    await SharedPrefsHelper.saveBool(StorageKeys.themeMode, isDark);
  }

  static bool? getThemeMode() {
    return SharedPrefsHelper.getBool(StorageKeys.themeMode);
  }
}
