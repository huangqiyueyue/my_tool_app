import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tool_app/data/models/item_model.dart';
import 'package:my_tool_app/data/repositories/item_repository.dart';

class ItemState {
  final List<ItemModel> items;
  final bool isLoading;
  final String? error;
  
  const ItemState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });
  
  ItemState copyWith({
    List<ItemModel>? items,
    bool? isLoading,
    String? error,
  }) {
    return ItemState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ItemNotifier extends StateNotifier<ItemState> {
  final ItemRepository repository;
  
  ItemNotifier(this.repository) : super(const ItemState());
  
  Future<void> loadItems() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final items = await repository.getAllItems();
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false, 
        error: e.toString(),
      );
    }
  }
  
  Future<void> addItem(String title, String? content) async {
    state = state.copyWith(isLoading: true);
    try {
      final newItem = await repository.addItem(title, content);
      state = state.copyWith(
        items: [...state.items, newItem],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
  
  Future<void> deleteItem(String id) async {
    final success = await repository.deleteItem(id);
    if (success) {
      state = state.copyWith(
        items: state.items.where((item) => item.id != id).toList(),
      );
    }
  }
  
  Future<void> updateItem(ItemModel updatedItem) async {
    final success = await repository.updateItem(updatedItem);
    if (success) {
      final index = state.items.indexWhere((item) => item.id == updatedItem.id);
      if (index != -1) {
        final newItems = List<ItemModel>.from(state.items);
        newItems[index] = updatedItem;
        state = state.copyWith(items: newItems);
      }
    }
  }
}
