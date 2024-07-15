import 'package:rick_and_morty/domain/use_cases/delete_character_use_case.dart';
import 'package:rick_and_morty/domain/use_cases/get_character_use_case.dart';
import 'package:rick_and_morty/domain/use_cases/get_characters_page_use_case.dart';
import 'package:rick_and_morty/domain/use_cases/get_most_recent_characters_use_case.dart';
import 'package:rick_and_morty/domain/use_cases/search_character_use_case.dart';

abstract class RickAndMortyComponent {
  GetCharactersPageUseCase get getCharactersPageUseCase;
  SearchCharacterUseCase get searchCharacterUseCase;
  GetCharacterUseCase get getCharacterUseCase;
  DeleteCharacterUseCase get deleteCharacterUseCase;
  GetMostRecentCharactersUseCase get getMostRecentCharactersUseCase;
}
