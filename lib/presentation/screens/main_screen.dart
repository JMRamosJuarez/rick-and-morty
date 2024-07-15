import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget/home_widget.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/presentation/blocs/characters/characters_bloc.dart';
import 'package:rick_and_morty/presentation/di/index.dart';
import 'package:rick_and_morty/presentation/widgets/character_list_item.dart';
import 'package:rick_and_morty/presentation/widgets/most_recent_characters.dart';
import 'package:rick_and_morty/presentation/widgets/search_character_text_field.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  /// Returns [PageRouteBuilder] that contains [BlocProvider<CharactersBloc>] >> [MainScreen]
  static PageRouteBuilder<MainScreen> buildScreen(RouteSettings settings) {
    return PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return BlocProvider(
            create: (_) {
              final charactersBloc = serviceProvider<CharactersBloc>();
              // Execute the [GetCharactersPageEvent] when the bloc is created to load the first page.
              charactersBloc.add(GetCharactersPageEvent());
              return charactersBloc;
            },
            child: const MainScreen(),
          );
        },
        transitionsBuilder: (_, animation, __, child) {
          /// Returns a [FadeTransition] for the screen.
          final tween = Tween<double>(begin: 0, end: 1);
          final opacity = animation.drive(tween);
          return FadeTransition(opacity: opacity, child: child);
        },
        settings: settings);
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  StreamSubscription? _homeWidgetSubscription;

  @override
  void initState() {
    super.initState();
    //Subscribe to the home widgets click events
    _homeWidgetSubscription = HomeWidget.widgetClicked.listen((Uri? uri) {
      final params = uri?.queryParameters ?? {};

      final id = int.parse(params['characterId'] ?? '1');

      // Use the [pushNamedAndRemoveUntil] method to prevent
      // the '/character' screen stack indefinitely above each other
      Navigator.of(context).pushNamedAndRemoveUntil('/character', (route) {
        return route.settings.name == '/';
      }, arguments: id);
    });
  }

  @override
  void dispose() {
    super.dispose();
    //Dispose the _homeWidgetSubscription
    _homeWidgetSubscription?.cancel();
    _homeWidgetSubscription = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocSelector<CharactersBloc, PaginationState, List<Character>>(
        selector: (state) {
          // At this point we only care about the list of [characters] not the pagination state itself.
          return state.data.characters;
        },
        builder: (_, characters) {
          return Column(
            children: [
              const SearchCharacterTextField(),
              const MostRecentCharacters(),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      // Load the next page when the scroll hits the bottom
                      context
                          .read<CharactersBloc>()
                          .add(GetCharactersPageEvent());
                    }
                    return false;
                  },
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: characters.length,
                      itemBuilder: (_, index) {
                        final item = characters[index];
                        return CharacterListItem(
                          item: item,
                          onPress: (character) {
                            Navigator.of(context)
                                .pushNamed('/character', arguments: item.id);
                          },
                        );
                      }),
                ),
              ),
            ],
          );
        },
      ),
    ));
  }
}
