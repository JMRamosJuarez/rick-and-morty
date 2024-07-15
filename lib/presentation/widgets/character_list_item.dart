import 'package:flutter/material.dart';
import 'package:rick_and_morty/domain/entities/character.dart';

class CharacterListItem extends StatelessWidget {
  final Character item;
  final Function(Character character) onPress;

  const CharacterListItem({
    super.key,
    required this.item,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(item),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              item.image,
              width: 80,
              height: 80,
            ),
            Container(margin: const EdgeInsets.all(8), child: Text(item.name))
          ],
        ),
      ),
    );
  }
}
