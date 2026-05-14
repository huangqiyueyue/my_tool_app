import 'package:sqflite/sqflite.dart';
import 'package:my_tool_app/data/local/database_helper.dart';
import 'package:my_tool_app/data/models/item_model.dart';

class ItemDao {
  static Future<List<ItemModel>> getAllItems() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('items');

    return List.generate(maps.length, (i) {
      return ItemModel.fromJson(maps[i]);
    });
  }

  static Future<void> insertItem(ItemModel item) async {
    final db = await DatabaseHelper.database;
    await db.insert(
      'items',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateItem(ItemModel item) async {
    final db = await DatabaseHelper.database;
    await db.update(
      'items',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  static Future<void> deleteItem(String id) async {
    final db = await DatabaseHelper.database;
    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
