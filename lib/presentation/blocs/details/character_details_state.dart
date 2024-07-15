part of 'character_details_bloc.dart';

@immutable
sealed class CharacterDetailsState {}

final class CharacterWaiting extends CharacterDetailsState {}

final class CharacterLoading extends CharacterDetailsState {}

final class CharacterError extends CharacterDetailsState {
  final AppError error;

  CharacterError({required this.error});
}

final class CharacterSuccess extends CharacterDetailsState {
  final Character character;
  CharacterSuccess({required this.character});
}
