import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/di/components/rick_and_morty_component.dart';
import 'package:rick_and_morty/domain/entities/app_error.dart';
import 'package:rick_and_morty/domain/entities/character.dart';

part 'character_details_event.dart';
part 'character_details_state.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  final RickAndMortyComponent _rickAndMortyComponent;

  CharacterDetailsBloc({required RickAndMortyComponent rickAndMortyComponent})
      : _rickAndMortyComponent = rickAndMortyComponent,
        super(CharacterWaiting()) {
    on<GetCharacterEvent>((event, emit) async {
      emit(CharacterLoading());

      final response =
          await _rickAndMortyComponent.getCharacterUseCase(event.id);

      response.fold((error) {
        emit(CharacterError(error: error));
      }, (character) {
        emit(CharacterSuccess(character: character));
      });
    });
  }
}
