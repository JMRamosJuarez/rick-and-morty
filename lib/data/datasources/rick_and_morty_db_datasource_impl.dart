import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rick_and_morty/domain/access/app_db_client.dart';
import 'package:rick_and_morty/domain/datasources/rick_and_morty_datasource.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/entities/characters_page.dart';

class RickAndMortyDbDatasourceImpl extends RickAndMortyDatasource {
  final AppDbClient _appDbClient;

  String get _tableName => dotenv.env['TABLE_NAME'] ?? 'characters';

  RickAndMortyDbDatasourceImpl({required AppDbClient appDbClient})
      : _appDbClient = appDbClient;

  @override
  Future<CharactersPage> paginate(String page) async {
    throw UnsupportedError(
        "The method 'paginate' is not support in RickAndMortyDbDatasourceImpl");
  }

  @override
  Future<CharactersPage> searchCharacter(String name) async {
    throw UnsupportedError(
        "The method 'paginate' is not support in RickAndMortyDbDatasourceImpl");
  }

  @override
  Future<Character> getCharacter(int id) async {
    throw UnsupportedError(
        "The method 'paginate' is not support in RickAndMortyDbDatasourceImpl");
  }

  @override
  Future<int> deleteCharacter(int id) async {
    return await _appDbClient
        .delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  @override
  Future<Character> setMostRecentCharacter(Character character) async {
    final values = character.toJson();
    values['updated_at'] = DateTime.now().millisecondsSinceEpoch / 1000;

    final json = await _appDbClient.insert(_tableName, values);

    return Character.fromJson(json);
  }

  @override
  Future<List<Character>> getMostRecentCharacters(int limit) async {
    final items = await _appDbClient.query(_tableName,
        orderBy: "updated_at DESC", limit: limit);
    return List.from(items.map((json) => Character.fromJson(json)));
  }
}
