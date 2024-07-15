import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/entities/characters_page.dart';

abstract class RickAndMortyDatasource {
  Future<CharactersPage> paginate(String page);
  Future<CharactersPage> searchCharacter(String name);
  Future<Character> getCharacter(int id);
  Future<int> deleteCharacter(int id);
  Future<Character> setMostRecentCharacter(Character character);
  Future<List<Character>> getMostRecentCharacters(int limit);
}
