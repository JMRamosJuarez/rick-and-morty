import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget/home_widget.dart';
import 'package:rick_and_morty/presentation/blocs/details/character_details_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/most_recent_characters/most_recent_characters_bloc.dart';
import 'package:rick_and_morty/presentation/di/index.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

  /// Returns [PageRouteBuilder] that contains [BlocProvider<CharacterDetailsBloc>] >> [CharacterDetailScreen]
  static PageRouteBuilder<CharacterDetailScreen> buildScreen(
      RouteSettings settings) {
    return PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          final characterId = settings.arguments as int;
          return BlocProvider(
            create: (_) {
              final characterDetailsBloc =
                  serviceProvider<CharacterDetailsBloc>();
              // Execute the [GetCharacterEvent] when the bloc is created
              characterDetailsBloc.add(GetCharacterEvent(id: characterId));
              return characterDetailsBloc;
            },
            child: const CharacterDetailScreen(),
          );
        },
        transitionsBuilder: (_, animation, __, child) {
          // Returns a [SlideTransition] to display the screen from Right to Left.
          final tween =
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
          final position = animation.drive(tween);
          return SlideTransition(position: position, child: child);
        },
        settings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: BlocConsumer<CharacterDetailsBloc, CharacterDetailsState>(
          listener: (_, state) {
            if (state is CharacterSuccess) {
              // Update the [MostRecentCharacters] widget when the [CharacterSuccess] state it's emmited
              final bloc = context.read<MostRecentCharactersBloc>();
              bloc.add(GetMostRecentCharactersEvent(limit: 10));
            }
          },
          builder: (_, state) {
            switch (state) {
              // We can return a different view based on each type of state
              // but at this point we only care about the [CharacterSuccess] state
              case CharacterSuccess():
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                        state.character.image,
                      ),
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
                            "Location: ${state.character.location?.name ?? 'Unknown'}")),
                    TextButton(
                        onPressed: () async {
                          await HomeWidget.saveWidgetData(
                              "id", state.character.id);
                          await HomeWidget.renderFlutterWidget(
                              Image.network(
                                state.character.image,
                                width: 40,
                                height: 40,
                              ),
                              key: 'image',
                              logicalSize: const Size(40, 40));
                          await HomeWidget.saveWidgetData(
                              "name", state.character.name);
                          HomeWidget.requestPinWidget(
                            name: 'CharacterWidget',
                            androidName: 'CharacterWidget',
                            qualifiedAndroidName:
                                'com.example.rick_and_morty.CharacterWidget',
                          );
                        },
                        child: const Text("Set as home widget"))
                  ],
                );
              default:
                //Return an empty column by default
                return const Column();
            }
          },
        ),
      )),
    );
  }
}
