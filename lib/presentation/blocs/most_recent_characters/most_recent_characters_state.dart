part of 'most_recent_characters_bloc.dart';

@immutable
sealed class MostRecentCharactersState {}

final class RecentCharactersWaiting extends MostRecentCharactersState {}

final class RecentCharactersLoading extends MostRecentCharactersState {}

final class RecentCharactersError extends MostRecentCharactersState {
  final AppError error;

  RecentCharactersError({required this.error});
}

final class RecentCharactersSuccess extends MostRecentCharactersState {
  final List<Character> characters;
  RecentCharactersSuccess({required this.characters});
}
