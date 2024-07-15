import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/characters/characters_bloc.dart';
import 'package:rick_and_morty/utils/debouncer.dart';

class SearchCharacterTextField extends StatefulWidget {
  const SearchCharacterTextField({super.key});

  @override
  State<SearchCharacterTextField> createState() =>
      _SearchCharacterTextFieldState();
}

class _SearchCharacterTextFieldState extends State<SearchCharacterTextField> {
  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 750));

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CharactersBloc>();

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: "Search"),
        onChanged: (name) => _debouncer(() {
          bloc.add(SearchCharacterEvent(name: name));
        }),
      ),
    );
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }
}
