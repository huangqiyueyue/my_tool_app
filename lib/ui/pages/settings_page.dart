import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tool_app/state/providers/settings_provider.dart';
import 'package:my_tool_app/ui/styles/spacing.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        padding: AppSpacing.edgeInsetsAll16,
        children: [
          ListTile(
            title: const Text('深色模式'),
            subtitle: Text(settings.darkMode ? '已开启' : '已关闭'),
            trailing: Switch(
              value: settings.darkMode,
              onChanged: (value) {
                ref.read(settingsProvider.notifier).toggleTheme();
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('关于'),
            subtitle: const Text('版本 1.0.0'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'My Tool App',
                applicationVersion: '1.0.0',
              );
            },
          ),
        ],
      ),
    );
  }
}
