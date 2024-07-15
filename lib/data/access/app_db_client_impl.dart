import 'package:rick_and_morty/domain/access/app_db_client.dart';
import 'package:sqflite/sqflite.dart';

class AppDbClientImpl extends AppDbClient {
  final Future<Database> Function() dbClient;

  AppDbClientImpl({required this.dbClient});

  @override
  Future<Map<String, dynamic>> insert(
      String table, Map<String, dynamic> item) async {
    final client = await dbClient();
    await client.insert(table, item,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return item;
  }

  @override
  Future<List<Map<String, dynamic>>> query(String table,
      {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset}) async {
    final client = await dbClient();
    return await client.query(table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
  }

  @override
  Future<Map<String, dynamic>> update(String table, Map<String, dynamic> item,
      {String? where, List<Object?>? whereArgs}) async {
    final client = await dbClient();
    await client.update(table, item,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return item;
  }

  @override
  Future<int> delete(String table,
      {String? where, List<Object?>? whereArgs}) async {
    final client = await dbClient();
    return await client.delete(table, where: where, whereArgs: whereArgs);
  }
}
