import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rick_and_morty/presentation/app.dart';
import 'package:rick_and_morty/presentation/di/index.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  initDependencies();

  runApp(const App());
}
