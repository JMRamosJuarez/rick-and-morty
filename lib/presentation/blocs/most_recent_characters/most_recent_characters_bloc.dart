import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/di/components/rick_and_morty_component.dart';
import 'package:rick_and_morty/domain/entities/app_error.dart';
import 'package:rick_and_morty/domain/entities/character.dart';

part 'most_recent_characters_event.dart';
part 'most_recent_characters_state.dart';

class MostRecentCharactersBloc
    extends Bloc<MostRecentCharactersEvent, MostRecentCharactersState> {
  final RickAndMortyComponent _rickAndMortyComponent;

  MostRecentCharactersBloc(
      {required RickAndMortyComponent rickAndMortyComponent})
      : _rickAndMortyComponent = rickAndMortyComponent,
        super(RecentCharactersWaiting()) {
    on<GetMostRecentCharactersEvent>((event, emit) async {
      final response = await _rickAndMortyComponent
          .getMostRecentCharactersUseCase(event.limit);

      response.fold((error) {
        emit(RecentCharactersError(error: error));
      }, (characters) {
        emit(RecentCharactersSuccess(characters: characters));
      });
    });

    on<DeleteRecentCharacterEvent>((event, emit) async {
      await _rickAndMortyComponent.deleteCharacterUseCase(event.id);

      final response = await _rickAndMortyComponent
          .getMostRecentCharactersUseCase(event.limit);

      response.fold((error) {
        emit(RecentCharactersError(error: error));
      }, (characters) {
        emit(RecentCharactersSuccess(characters: characters));
      });
    });
  }
}
