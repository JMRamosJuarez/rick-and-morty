import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/entities/page_info.dart';

class CharactersPage {
  final PageInfo info;
  final List<Character> results;

  const CharactersPage({required this.info, required this.results});

  factory CharactersPage.fromJson(Map<String, dynamic> json) => CharactersPage(
        info: PageInfo.fromJson(json["info"]),
        results: List<Character>.from(
            json["results"].map((x) => Character.fromJson(x))),
      );
}
