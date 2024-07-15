part of '../characters_bloc.dart';

@immutable
sealed class PageState {}

final class PageWaiting extends PageState {}

final class PageLoading extends PageState {}

final class PageError extends PageState {
  final AppError error;

  PageError({required this.error});
}

final class PageSuccess extends PageState {
  final List<Character> characters;
  PageSuccess({required this.characters});
}
