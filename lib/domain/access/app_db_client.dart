abstract class AppDbClient {
  Future<Map<String, dynamic>> insert(String table, Map<String, dynamic> item);

  Future<List<Map<String, dynamic>>> query(String table,
      {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset});

  Future<Map<String, dynamic>> update(String table, Map<String, dynamic> item,
      {String? where, List<Object?>? whereArgs});

  Future<int> delete(String table, {String? where, List<Object?>? whereArgs});
}
