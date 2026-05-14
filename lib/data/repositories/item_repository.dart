import 'package:my_tool_app/data/local/dao/item_dao.dart';
import 'package:my_tool_app/data/local/shared_prefs_helper.dart';
import 'package:my_tool_app/data/models/item_model.dart';
import 'dart:convert';

class ItemRepository {
  Future<List<ItemModel>> getAllItems() async {
    try {
      final items = await ItemDao.getAllItems();
      if (items.isNotEmpty) {
        return items;
      }
      
      final cachedJson = SharedPrefsHelper.getStringList('items');
      if (cachedJson != null && cachedJson.isNotEmpty) {
        return cachedJson
            .map((json) => ItemModel.fromJson(jsonDecode(json)))
            .toList();
      }
      
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<ItemModel> addItem(String title, String? content) async {
    final now = DateTime.now();
    final item = ItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
    );
    
    await ItemDao.insertItem(item);
    
    final allItems = await getAllItems();
    await _cacheItems(allItems);
    
    return item;
  }

  Future<bool> deleteItem(String id) async {
    try {
      await ItemDao.deleteItem(id);
      final allItems = await getAllItems();
      await _cacheItems(allItems);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateItem(ItemModel updatedItem) async {
    try {
      await ItemDao.updateItem(updatedItem);
      final allItems = await getAllItems();
      await _cacheItems(allItems);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _cacheItems(List<ItemModel> items) async {
    final jsonList = items.map((item) => jsonEncode(item.toJson())).toList();
    await SharedPrefsHelper.saveStringList('items', jsonList);
  }
}
