import 'package:either_dart/either.dart';
import 'package:rick_and_morty/domain/datasources/rick_and_morty_datasource.dart';
import 'package:rick_and_morty/domain/entities/app_error.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/entities/characters_page.dart';
import 'package:rick_and_morty/domain/repositories/rick_and_morty_repository.dart';

class RickAndMortyRepositoryImpl extends RickAndMortyRepository {
  final RickAndMortyDatasource _dbDatasource;
  final RickAndMortyDatasource _remoteDatasource;

  RickAndMortyRepositoryImpl(
      {required RickAndMortyDatasource dbDatasource,
      required RickAndMortyDatasource remoteDatasource})
      : _dbDatasource = dbDatasource,
        _remoteDatasource = remoteDatasource;

  @override
  Future<Either<AppError, CharactersPage>> paginate(String page) async {
    try {
      final response = await _remoteDatasource.paginate(page);
      return Right(response);
    } on AppError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<AppError, CharactersPage>> searchCharacter(String name) async {
    try {
      final response = await _remoteDatasource.searchCharacter(name);
      return Right(response);
    } on AppError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<AppError, Character>> getCharacter(int id) async {
    try {
      final response = await _remoteDatasource.getCharacter(id);
      final character = await _dbDatasource.setMostRecentCharacter(response);
      return Right(character);
    } on AppError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<AppError, int>> deleteCharacter(int id) async {
    try {
      final response = await _dbDatasource.deleteCharacter(id);
      return Right(response);
    } on AppError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<AppError, List<Character>>> getMostRecentCharacters(
      int limit) async {
    try {
      final response = await _dbDatasource.getMostRecentCharacters(limit);
      return Right(response);
    } on AppError catch (error) {
      return Left(error);
    }
  }
}
