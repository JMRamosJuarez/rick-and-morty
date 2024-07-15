part of 'most_recent_characters_bloc.dart';

@immutable
sealed class MostRecentCharactersEvent {}

final class GetMostRecentCharactersEvent extends MostRecentCharactersEvent {
  final int limit;

  GetMostRecentCharactersEvent({required this.limit});
}

final class DeleteRecentCharacterEvent extends MostRecentCharactersEvent {
  final int id;
  final int limit;

  DeleteRecentCharacterEvent({required this.id, required this.limit});
}
