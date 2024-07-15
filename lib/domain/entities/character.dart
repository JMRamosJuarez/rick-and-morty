import 'dart:convert';

import 'package:rick_and_morty/domain/entities/character_location.dart';
import 'package:rick_and_morty/domain/entities/gender.dart';
import 'package:rick_and_morty/domain/entities/json_entity.dart';
import 'package:rick_and_morty/domain/entities/species.dart';
import 'package:rick_and_morty/domain/entities/status.dart';

class Character extends JsonEntity {
  final int id;
  final String name;
  final Status status;
  final Species species;
  final Gender gender;
  final String image;
  final String url;
  final List<String> episodes;
  final CharacterLocation? origin;
  final CharacterLocation? location;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.url,
    required this.episodes,
    required this.origin,
    required this.location,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final episodeValues = json["episode"];
    final episodes =
        episodeValues is String ? jsonDecode(episodeValues) : episodeValues;

    final originValue = json["origin"];
    final origin =
        originValue is String ? jsonDecode(originValue) : originValue;

    final locationValue = json["location"];
    final location =
        originValue is String ? jsonDecode(locationValue) : locationValue;

    return Character(
      id: json["id"] ?? -1,
      name: json["name"] ?? '-',
      status: statusValues.map[json["status"] ?? '-'] ?? Status.UNKNOWN,
      species: speciesValues.map[json["species"] ?? '-'] ?? Species.UNKNOWN,
      gender: genderValues.map[json["gender"] ?? '-'] ?? Gender.UNKNOWN,
      image: json["image"] ?? "-",
      url: json["url"] ?? "-",
      episodes: List<String>.from(episodes.map((x) => x)),
      origin: CharacterLocation.fromJson(origin),
      location: CharacterLocation.fromJson(location),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "gender": genderValues.reverse[gender],
        "image": image,
        "url": url,
        "episode": '["${episodes.join('", "')}"]',
        "origin": origin?.toString(),
        "location": location?.toString(),
      };
}
