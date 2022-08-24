import 'package:news_app/src/models/favorite/categories.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'category.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Categories(id INTEGER PRIMARY KEY AUTOINCREMENT,description TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<List<Categories>> getItems() async {
    final db = await SqliteService().initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'Categories',
    );
    return queryResult.map((e) => Categories.fromMap(e)).toList();
  }
}
