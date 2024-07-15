import 'package:rick_and_morty/domain/entities/json_entity.dart';

class CharacterLocation extends JsonEntity {
  final String name;
  final String url;

  const CharacterLocation({
    required this.name,
    required this.url,
  });

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      CharacterLocation(
        name: json["name"] ?? '-',
        url: json["url"] ?? '-',
      );

  @override
  Map<String, dynamic> toJson() => {"name": name, "url": url};

  @override
  String toString() {
    return '{"name": "$name", "url": "$url"}';
  }
}
