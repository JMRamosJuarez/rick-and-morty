import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rick_and_morty/domain/di/components/rick_and_morty_component.dart';
import 'package:rick_and_morty/domain/entities/app_error.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/entities/page_info.dart';

part './state/page_state.dart';
part './state/page_data_state.dart';
part './state/pagination_state.dart';

part './characters_event.dart';

class CharactersBloc extends Bloc<CharactersEvent, PaginationState> {
  final RickAndMortyComponent _rickAndMortyComponent;

  CharactersBloc({required RickAndMortyComponent rickAndMortyComponent})
      : _rickAndMortyComponent = rickAndMortyComponent,
        super(PaginationState(
            page: PageWaiting(),
            data: PageDataState(
                info: PageInfo(
                    count: 0, pages: 0, next: dotenv.env['BASE_URL'] ?? '-'),
                characters: []))) {
    on<GetCharactersPageEvent>((event, emit) async {
      if (state.page is PageLoading) {
        return;
      }

      final nextPage = state.data.info.next;

      if (nextPage == null) {
        return;
      }

      emit(state.copyWith(page: PageLoading()));

      final currentCharacters = state.data.characters;

      final response =
          await _rickAndMortyComponent.getCharactersPageUseCase(nextPage);

      response.fold(
          (error) => {emit(state.copyWith(page: PageError(error: error)))},
          (page) {
        final characters = [...currentCharacters, ...page.results];

        emit(PaginationState(
            page: PageSuccess(characters: characters),
            data: PageDataState(info: page.info, characters: characters)));
      });
    });

    on<SearchCharacterEvent>((event, emit) async {
      emit(state.copyWith(page: PageLoading()));

      final response =
          await _rickAndMortyComponent.searchCharacterUseCase(event.name);

      response.fold(
          (error) => {emit(state.copyWith(page: PageError(error: error)))},
          (page) {
        emit(PaginationState(
            page: PageSuccess(characters: page.results),
            data: PageDataState(info: page.info, characters: page.results)));
      });
    });
  }
}
