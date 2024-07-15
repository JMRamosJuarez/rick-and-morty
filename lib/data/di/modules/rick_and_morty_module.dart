import 'package:rick_and_morty/data/datasources/rick_and_morty_db_datasource_impl.dart';
import 'package:rick_and_morty/data/datasources/rick_and_morty_remote_datasource_impl.dart';
import 'package:rick_and_morty/data/repositories/rick_and_morty_repository_impl.dart';
import 'package:rick_and_morty/domain/access/app_db_client.dart';
import 'package:rick_and_morty/domain/access/app_http_client.dart';
import 'package:rick_and_morty/domain/datasources/rick_and_morty_datasource.dart';
import 'package:rick_and_morty/domain/di/modules/rick_and_morty_module.dart';
import 'package:rick_and_morty/domain/repositories/rick_and_morty_repository.dart';

class RickAndMortyModuleImpl extends RickAndMortyModule {
  final AppDbClient _appDbClient;
  final AppHttpClient _appHttpClient;

  RickAndMortyDatasource? _dbDatasource;
  RickAndMortyDatasource? _remoteDatasource;
  RickAndMortyRepositoryImpl? _repository;

  RickAndMortyModuleImpl(
      {required AppDbClient appDbClient, required AppHttpClient appHttpClient})
      : _appDbClient = appDbClient,
        _appHttpClient = appHttpClient;

  @override
  RickAndMortyDatasource get dbDatasource {
    return _dbDatasource ??=
        RickAndMortyDbDatasourceImpl(appDbClient: _appDbClient);
  }

  @override
  RickAndMortyDatasource get remoteDatasource {
    return _remoteDatasource ??=
        RickAndMortyRemoteDatasourceImpl(httpClient: _appHttpClient);
  }

  @override
  RickAndMortyRepository get repository {
    return _repository ??= RickAndMortyRepositoryImpl(
        dbDatasource: dbDatasource, remoteDatasource: remoteDatasource);
  }
}
