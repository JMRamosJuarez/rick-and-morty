part of './characters_bloc.dart';

@immutable
sealed class CharactersEvent {}

final class GetCharactersPageEvent extends CharactersEvent {}

final class SearchCharacterEvent extends CharactersEvent {
  final String name;

  SearchCharacterEvent({required this.name});
}
