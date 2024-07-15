part of './characters_bloc.dart';

@immutable
sealed class CharactersEvent {}

final class GetCharactersPageEvent extends CharactersEvent {}
