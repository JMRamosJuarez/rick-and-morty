import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/most_recent_characters/most_recent_characters_bloc.dart';
import 'package:rick_and_morty/presentation/widgets/most_recent_character_item.dart';

class MostRecentCharacters extends StatelessWidget {
  const MostRecentCharacters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Most recent characters'),
        BlocBuilder<MostRecentCharactersBloc, MostRecentCharactersState>(
          builder: (_, state) {
            switch (state) {
              case RecentCharactersSuccess():
                // We can return a different view based on each type of state
                // but at this point we only care about the [RecentCharactersSuccess] state
                if (state.characters.isEmpty) {
                  return const SizedBox(
                    height: 40,
                    child: Center(child: Text('You have 0 recent characters')),
                  );
                }
                return SizedBox(
                  height: 40,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.characters.length,
                      itemBuilder: (_, index) {
                        final item = state.characters[index];
                        return MostRecentCharacterItem(
                            character: item,
                            onPress: (character) {
                              Navigator.of(context).pushNamed('/character',
                                  arguments: character.id);
                            },
                            onDelete: (character) {
                              final bloc =
                                  context.read<MostRecentCharactersBloc>();
                              bloc.add(DeleteRecentCharacterEvent(
                                  id: character.id, limit: 10));
                            });
                      }),
                );
              default:
                //Return placeholder text by default
                return const SizedBox(
                  height: 40,
                  child: Center(child: Text('You have 0 recent characters')),
                );
            }
          },
        )
      ],
    );
  }
}
