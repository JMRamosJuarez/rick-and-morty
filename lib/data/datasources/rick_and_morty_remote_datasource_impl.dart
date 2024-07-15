import 'package:rick_and_morty/domain/access/app_http_client.dart';
import 'package:rick_and_morty/domain/datasources/rick_and_morty_datasource.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/entities/characters_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RickAndMortyRemoteDatasourceImpl extends RickAndMortyDatasource {
  final AppHttpClient _httpClient;

  String get _baseUrl => dotenv.env['BASE_URL'] ?? '-';

  RickAndMortyRemoteDatasourceImpl({required AppHttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<CharactersPage> paginate(String page) async {
    final Map<String, dynamic> response = await _httpClient.get(page);
    return CharactersPage.fromJson(response);
  }

  @override
  Future<CharactersPage> searchCharacter(String name) async {
    final Map<String, dynamic> response =
        await _httpClient.get(_baseUrl, queryParameters: {'name': name});
    return CharactersPage.fromJson(response);
  }

  @override
  Future<Character> getCharacter(int id) async {
    final Map<String, dynamic> response =
        await _httpClient.get("$_baseUrl/$id");
    return Character.fromJson(response);
  }

  @override
  Future<int> deleteCharacter(int id) {
    throw UnsupportedError(
        "The method 'deleteCharacter' is not support in RickAndMortyRemoteDatasourceImpl");
  }

  @override
  Future<Character> setMostRecentCharacter(Character character) {
    throw UnsupportedError(
        "The method 'setMostRecentCharacter' is not support in RickAndMortyRemoteDatasourceImpl");
  }

  @override
  Future<List<Character>> getMostRecentCharacters(int limit) async {
    throw UnsupportedError(
        "The method 'getMostRecentCharacters' is not support in RickAndMortyRemoteDatasourceImpl");
  }
}
