import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:rick_and_morty/data/access/app_db_client_impl.dart';
import 'package:rick_and_morty/data/access/app_http_client_impl.dart';
import 'package:rick_and_morty/data/di/components/rick_and_morty_component_impl.dart';
import 'package:rick_and_morty/data/di/modules/rick_and_morty_module.dart';
import 'package:rick_and_morty/domain/access/app_db_client.dart';
import 'package:rick_and_morty/domain/access/app_http_client.dart';
import 'package:rick_and_morty/domain/di/components/rick_and_morty_component.dart';
import 'package:rick_and_morty/domain/di/modules/rick_and_morty_module.dart';
import 'package:rick_and_morty/presentation/blocs/characters/characters_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/details/character_details_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/most_recent_characters/most_recent_characters_bloc.dart';
import 'package:sqflite/sqflite.dart';

final serviceProvider = GetIt.instance;

/// Init app dependencies.
///
/// [AppDbClient] generates a lazy singleton using [AppDbClientImpl]
///
/// [AppHttpClient] generates a lazy singleton using [AppHttpClientImpl]
///
/// [RickAndMortyModule] generates a lazy singleton using [RickAndMortyModuleImpl]
///
/// [RickAndMortyComponentImpl] generates a lazy singleton using [RickAndMortyComponentImpl]
///
/// [MostRecentCharactersBloc] is registered as a factory because it's a [Bloc] and the [BlocProvider] disposes each instance automatically
///
/// [CharactersBloc] is registered as a factory because it's a [Bloc] and the [BlocProvider] disposes each instance automatically
///
/// [CharacterDetailsBloc] is registered as a factory because it's a [Bloc] and the [BlocProvider] disposes each instance automatically
void initDependencies() {
  serviceProvider.registerLazySingleton<AppDbClient>(() {
    Future<Database> dbClient() async {
      final dbPaths = await getDatabasesPath();
      final dbPath = join(dbPaths, 'characters_database.db');
      return await openDatabase(dbPath, version: 1, onCreate: (db, _) {
        return db.execute(
            "CREATE TABLE IF NOT EXISTS characters(id INTEGER PRIMARY KEY, name TEXT, status TEXT, species TEXT, gender TEXT, image TEXT, url TEXT, episode TEXT, origin TEXT, location TEXT, updated_at INTEGER)");
      });
    }

    return AppDbClientImpl(dbClient: dbClient);
  });

  serviceProvider.registerLazySingleton<AppHttpClient>(() {
    final options = BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );

    final instance = Dio(options);

    return AppHttpClientImpl(dio: instance);
  });

  serviceProvider.registerLazySingleton<RickAndMortyModule>(() =>
      RickAndMortyModuleImpl(
          appDbClient: serviceProvider(), appHttpClient: serviceProvider()));

  serviceProvider.registerLazySingleton<RickAndMortyComponent>(
      () => RickAndMortyComponentImpl(module: serviceProvider()));

  serviceProvider.registerFactory<MostRecentCharactersBloc>(
      () => MostRecentCharactersBloc(rickAndMortyComponent: serviceProvider()));

  serviceProvider.registerFactory<CharactersBloc>(
      () => CharactersBloc(rickAndMortyComponent: serviceProvider()));

  serviceProvider.registerFactory<CharacterDetailsBloc>(
      () => CharacterDetailsBloc(rickAndMortyComponent: serviceProvider()));
}
