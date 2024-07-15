import 'package:rick_and_morty/domain/datasources/rick_and_morty_datasource.dart';
import 'package:rick_and_morty/domain/repositories/rick_and_morty_repository.dart';

abstract class RickAndMortyModule {
  RickAndMortyDatasource get dbDatasource;
  RickAndMortyDatasource get remoteDatasource;
  RickAndMortyRepository get repository;
}
