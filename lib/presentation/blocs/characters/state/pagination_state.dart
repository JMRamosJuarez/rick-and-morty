part of '../characters_bloc.dart';

@immutable
final class PaginationState {
  final PageState page;
  final PageDataState data;

  const PaginationState({required this.page, required this.data});

  PaginationState copyWith({PageState? page, PageDataState? data}) {
    return PaginationState(page: page ?? this.page, data: data ?? this.data);
  }
}
