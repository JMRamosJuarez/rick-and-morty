part of 'character_details_bloc.dart';

@immutable
sealed class CharacterDetailsEvent {}

final class GetCharacterEvent extends CharacterDetailsEvent {
  final int id;

  GetCharacterEvent({required this.id});
}
