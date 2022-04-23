import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/shop_model.dart';

class DatabaseShopStore {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'shopModelDatabase.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE shopModelDatabaseTable(id INTEGER PRIMARY KEY, itemName TEXT, itemPrice TEXT, itemDate TEXT, itemQuantity TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(ShopModel task) async {
    Database db = await database();
    int data = await db.insert('shopModelDatabaseTable', task.toMap());
    return data;
  }

  Future<List<ShopModel>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('shopModelDatabaseTable');
    List<ShopModel> tasksList =
        tasks.isNotEmpty ? tasks.map((e) => ShopModel.fromMap(e)).toList() : [];
    return tasksList;
  }

  Future<bool> updateTaskList(ShopModel item) async {
    final Database db = await database();
    final rows = await db.update(
      'shopModelDatabaseTable',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM shopModelDatabaseTable WHERE id = '$id'");
  }
}
