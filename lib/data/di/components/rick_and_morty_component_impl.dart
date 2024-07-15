import 'package:rick_and_morty/domain/di/components/rick_and_morty_component.dart';
import 'package:rick_and_morty/domain/di/modules/rick_and_morty_module.dart';
import 'package:rick_and_morty/domain/use_cases/delete_character_use_case.dart';
import 'package:rick_and_morty/domain/use_cases/get_character_use_case.dart';
import 'package:rick_and_morty/domain/use_cases/get_characters_page_use_case.dart';
import 'package:rick_and_morty/domain/use_cases/get_most_recent_characters_use_case.dart';
import 'package:rick_and_morty/domain/use_cases/search_character_use_case.dart';

class RickAndMortyComponentImpl extends RickAndMortyComponent {
  final RickAndMortyModule _module;

  GetCharactersPageUseCase? _getPageUseCase;
  SearchCharacterUseCase? _searchCharacterUseCase;
  GetCharacterUseCase? _getCharacterUseCase;
  DeleteCharacterUseCase? _deleteCharacterUseCase;
  GetMostRecentCharactersUseCase? _getMostRecentCharactersUseCase;

  RickAndMortyComponentImpl({required RickAndMortyModule module})
      : _module = module;

  @override
  GetCharactersPageUseCase get getCharactersPageUseCase {
    return _getPageUseCase ??=
        GetCharactersPageUseCase(repository: _module.repository);
  }

  @override
  SearchCharacterUseCase get searchCharacterUseCase {
    return _searchCharacterUseCase ??=
        SearchCharacterUseCase(repository: _module.repository);
  }

  @override
  GetCharacterUseCase get getCharacterUseCase {
    return _getCharacterUseCase ??=
        GetCharacterUseCase(repository: _module.repository);
  }

  @override
  DeleteCharacterUseCase get deleteCharacterUseCase {
    return _deleteCharacterUseCase ??=
        DeleteCharacterUseCase(repository: _module.repository);
  }

  @override
  GetMostRecentCharactersUseCase get getMostRecentCharactersUseCase {
    return _getMostRecentCharactersUseCase ??=
        GetMostRecentCharactersUseCase(repository: _module.repository);
  }
}
