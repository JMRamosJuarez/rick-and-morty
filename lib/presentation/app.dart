import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget/home_widget.dart';
import 'package:rick_and_morty/presentation/blocs/most_recent_characters/most_recent_characters_bloc.dart';
import 'package:rick_and_morty/presentation/di/index.dart';
import 'package:rick_and_morty/presentation/screens/character_detail_screen.dart';
import 'package:rick_and_morty/presentation/screens/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = serviceProvider<MostRecentCharactersBloc>();
        bloc.add(GetMostRecentCharactersEvent(limit: 10));
        return bloc;
      },
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MainScreen.buildScreen(settings);
            case '/character':
              return CharacterDetailScreen.buildScreen(settings);
            default:
              throw Exception("Route not found");
          }
        },
      ),
    );
  }
}
