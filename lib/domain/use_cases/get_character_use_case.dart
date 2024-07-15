import 'package:either_dart/either.dart';
import 'package:rick_and_morty/domain/entities/app_error.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/repositories/rick_and_morty_repository.dart';
import 'package:rick_and_morty/domain/use_cases/use_case.dart';

class GetCharacterUseCase extends UseCase<int, Character> {
  final RickAndMortyRepository _repository;

  GetCharacterUseCase({required RickAndMortyRepository repository})
      : _repository = repository;

  @override
  Future<Either<AppError, Character>> call(int request) async {
    return await _repository.getCharacter(request);
  }
}
