import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
      "CREATE TABLE Categories(id INTEGER PRIMARY KEY AUTOINCREMENT,description TEXT NOT NULL)",
    );
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'categories.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new category
  static Future<int> createItem(String description) async {
    final db = await SQLHelper.db();
    final data = {'description': description};
    final id = await db.insert('categories', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all categories
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('categories', orderBy: "id");
  }

  // Read a single cateogy by id
  static Future<List<Map<String, dynamic>>> getItem(String description) async {
    final db = await SQLHelper.db();
    return db.query('categories',
        where: "description = ?", whereArgs: [description], limit: 1);
  }

  // Delete
  static Future<void> deleteItem(String description) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("categories",
          where: "description = ?", whereArgs: [description]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteItemById(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
