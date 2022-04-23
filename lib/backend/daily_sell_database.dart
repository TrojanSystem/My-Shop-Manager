import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/shop_model.dart';

class DatabaseDailySell {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'dailySellDatabase.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE dailySellTable(id INTEGER PRIMARY KEY, itemName TEXT,total TEXT, itemPrice TEXT, itemDate TEXT, itemQuantity TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(ShopModel task) async {
    Database db = await database();
    int data = await db.insert('dailySellTable', task.toMap());
    return data;
  }

  Future<List<ShopModel>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('dailySellTable');
    List<ShopModel> tasksList =
        tasks.isNotEmpty ? tasks.map((e) => ShopModel.fromMap(e)).toList() : [];
    return tasksList;
  }

  Future<bool> updateTaskList(ShopModel item) async {
    final Database db = await database();
    final rows = await db.update(
      'dailySellTable',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM dailySellTable WHERE id = '$id'");
  }
}
