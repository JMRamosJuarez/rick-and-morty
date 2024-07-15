import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget/home_widget.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/presentation/blocs/characters/characters_bloc.dart';
import 'package:rick_and_morty/presentation/di/index.dart';
import 'package:rick_and_morty/presentation/widgets/character_list_item.dart';
import 'package:rick_and_morty/presentation/widgets/most_recent_characters.dart';
import 'package:rick_and_morty/presentation/widgets/search_character_text_field.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static PageRouteBuilder<MainScreen> buildScreen(RouteSettings route) {
    return PageRouteBuilder(pageBuilder: (_, __, ___) {
      return BlocProvider(
        create: (_) {
          final charactersBloc = serviceProvider<CharactersBloc>();
          charactersBloc.add(GetCharactersPageEvent());
          return charactersBloc;
        },
        child: const MainScreen(),
      );
    }, transitionsBuilder: (_, animation, __, child) {
      final opacity = animation.drive(Tween<double>(begin: 0, end: 1));
      return FadeTransition(opacity: opacity, child: child);
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeWidget.widgetClicked.listen((Uri? uri) {
      final params = uri?.queryParameters ?? {};

      final id = int.parse(params['characterId'] ?? '1');

      Navigator.of(context).pushNamed('/character', arguments: id);
    });
    return Scaffold(
        body: SafeArea(
      child: BlocSelector<CharactersBloc, PaginationState, List<Character>>(
        selector: (state) {
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
                            HomeWidget.saveWidgetData("id", item.id);
                            HomeWidget.renderFlutterWidget(
                                Image.network(
                                  item.image,
                                  width: 40,
                                  height: 40,
                                ),
                                key: 'image',
                                logicalSize: const Size(40, 40));
                            HomeWidget.saveWidgetData("name", item.name);
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
