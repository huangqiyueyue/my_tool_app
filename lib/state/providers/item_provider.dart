import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tool_app/state/notifiers/item_notifier.dart';
import 'package:my_tool_app/data/repositories/item_repository.dart';

final itemRepositoryProvider = Provider((ref) {
  return ItemRepository();
});

final itemProvider = StateNotifierProvider<ItemNotifier, ItemState>((ref) {
  final repository = ref.watch(itemRepositoryProvider);
  return ItemNotifier(repository);
});
