import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/details/character_details_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/most_recent_characters/most_recent_characters_bloc.dart';
import 'package:rick_and_morty/presentation/di/index.dart';
import 'package:rick_and_morty/presentation/widgets/most_recent_characters.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

  static PageRouteBuilder<CharacterDetailScreen> buildScreen(
      RouteSettings route) {
    return PageRouteBuilder(pageBuilder: (_, __, ___) {
      final characterId = route.arguments as int;
      return BlocProvider(
        create: (_) {
          final characterDetailsBloc = serviceProvider<CharacterDetailsBloc>();
          characterDetailsBloc.add(GetCharacterEvent(id: characterId));
          return characterDetailsBloc;
        },
        child: const CharacterDetailScreen(),
      );
    }, transitionsBuilder: (_, animation, __, child) {
      final position = animation.drive(
          Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)));
      return SlideTransition(position: position, child: child);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: BlocConsumer<CharacterDetailsBloc, CharacterDetailsState>(
          listener: (_, state) {
            if (state is CharacterSuccess) {
              final bloc = context.read<MostRecentCharactersBloc>();
              bloc.add(GetMostRecentCharactersEvent(limit: 10));
            }
          },
          builder: (_, state) {
            switch (state) {
              case CharacterWaiting():
              case CharacterLoading():
              case CharacterError():
                return const Column();
              case CharacterSuccess():
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      state.character.image,
                      width: 80,
                      height: 80,
                    ),
                    Container(
                        margin: const EdgeInsets.all(8),
                        child: Text(state.character.name)),
                    Container(
                        margin: const EdgeInsets.all(8),
                        child: Text("Status: ${state.character.status.name}")),
                    Container(
                        margin: const EdgeInsets.all(8),
                        child:
                            Text("Species: ${state.character.species.name}")),
                    Container(
                        margin: const EdgeInsets.all(8),
                        child: Text("Gender: ${state.character.gender.name}")),
                    Container(
                        margin: const EdgeInsets.all(8),
                        child: Text(
                            "Origin: ${state.character.origin?.name ?? 'Unknown'}")),
                    Container(
                        margin: const EdgeInsets.all(8),
                        child: Text(
                            "Location: ${state.character.location?.name ?? 'Unknown'}"))
                  ],
                );
            }
          },
        ),
      )),
    );
  }
}
