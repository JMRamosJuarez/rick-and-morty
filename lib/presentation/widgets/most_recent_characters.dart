import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/most_recent_characters/most_recent_characters_bloc.dart';

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
                return SizedBox(
                  height: 40,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.characters.length,
                      itemBuilder: (_, index) {
                        final item = state.characters[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/detail",
                                arguments: item.id);
                          },
                          onLongPress: () {
                            final bloc =
                                context.read<MostRecentCharactersBloc>();
                            bloc.add(DeleteRecentCharacterEvent(
                                id: item.id, limit: 10));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              item.image,
                              width: 40,
                              height: 40,
                            ),
                          ),
                        );
                      }),
                );
              default:
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
