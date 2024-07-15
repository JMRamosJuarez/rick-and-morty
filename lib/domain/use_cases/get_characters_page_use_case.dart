import 'package:either_dart/either.dart';
import 'package:rick_and_morty/domain/entities/app_error.dart';
import 'package:rick_and_morty/domain/entities/characters_page.dart';
import 'package:rick_and_morty/domain/repositories/rick_and_morty_repository.dart';
import 'package:rick_and_morty/domain/use_cases/use_case.dart';

class GetCharactersPageUseCase extends UseCase<String, CharactersPage> {
  final RickAndMortyRepository _repository;

  GetCharactersPageUseCase({required RickAndMortyRepository repository})
      : _repository = repository;

  @override
  Future<Either<AppError, CharactersPage>> call(String request) async {
    return await _repository.paginate(request);
  }
}
