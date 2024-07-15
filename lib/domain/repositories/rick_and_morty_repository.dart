import 'package:either_dart/either.dart';
import 'package:rick_and_morty/domain/entities/app_error.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/entities/characters_page.dart';

abstract class RickAndMortyRepository {
  Future<Either<AppError, CharactersPage>> paginate(String page);

  Future<Either<AppError, CharactersPage>> searchCharacter(String name);

  Future<Either<AppError, Character>> getCharacter(int id);

  Future<Either<AppError, int>> deleteCharacter(int id);

  Future<Either<AppError, List<Character>>> getMostRecentCharacters(int limit);
}
