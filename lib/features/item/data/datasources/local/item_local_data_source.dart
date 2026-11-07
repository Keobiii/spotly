import 'package:sqflite/sql.dart';

import '../../../../../core/database/app_database.dart';
import '../../models/item_model.dart';

class ItemLocalDataSource {
  final AppDatabase appDatabase;

  const ItemLocalDataSource(this.appDatabase);

  Future<int> addItem(ItemModel item) async {
    final db = await appDatabase.database;
    return await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ItemModel>> getItems() async {
    final db = await appDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => ItemModel.fromMap(map)).toList();
  }
}
