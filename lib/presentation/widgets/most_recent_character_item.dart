import 'package:flutter/material.dart';
import 'package:rick_and_morty/domain/entities/character.dart';

class MostRecentCharacterItem extends StatelessWidget {
  final Character character;
  final Function(Character character) onPress;
  final Function(Character character) onDelete;

  const MostRecentCharacterItem(
      {required this.character,
      required this.onPress,
      required this.onDelete,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(character),
      onLongPress: () => onDelete(character),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            character.image,
          ),
        ),
      ),
    );
  }
}
