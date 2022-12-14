import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sql;
import 'package:news_app/src/models/favorite/categories.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
      "CREATE TABLE Categories(id INTEGER PRIMARY KEY AUTOINCREMENT,description TEXT NOT NULL)",
    );
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'category.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new category
  static Future<int> createItem(Categories categories) async {
    final db = await SQLHelper.db();
    return db.insert('categories', categories.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  // Read all categories
  static Future<List<Categories>> getAll() async {
    final db = await SQLHelper.db();
    final map = await db.query('categories');
    return List.generate(map.length, (index) {
      return Categories(description: map[index]['description'] as String);
    });
  }

  // Read a single cateogy by category
  static Future<List<Categories>> getCategory(String description) async {
    final db = await SQLHelper.db();
    final map = await db.query('categories',
        where: "description = ?", whereArgs: [description], limit: 1);
    return List.generate(map.length, (index) {
      return Categories(description: map[index]['description'] as String);
    });
  }

  // Delete
  static Future<void> deleteCateogry(String description) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("categories",
          where: "description = ?", whereArgs: [description]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
