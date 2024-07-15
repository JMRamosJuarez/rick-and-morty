import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/screens/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MainScreen.buildScreen(settings);
          default:
            throw Exception("Route not found");
        }
      },
    );
  }
}