import 'package:either_dart/either.dart';
import 'package:rick_and_morty/domain/entities/app_error.dart';
import 'package:rick_and_morty/domain/repositories/rick_and_morty_repository.dart';
import 'package:rick_and_morty/domain/use_cases/use_case.dart';

class DeleteCharacterUseCase extends UseCase<int, int> {
  final RickAndMortyRepository _repository;

  DeleteCharacterUseCase({required RickAndMortyRepository repository})
      : _repository = repository;

  @override
  Future<Either<AppError, int>> call(int request) async {
    return await _repository.deleteCharacter(request);
  }
}
