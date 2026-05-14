import 'package:flutter/material.dart';
import 'package:my_tool_app/ui/styles/spacing.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: AppSpacing.edgeInsetsAll16,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
