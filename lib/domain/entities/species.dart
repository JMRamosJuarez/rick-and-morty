import 'package:rick_and_morty/domain/entities/enum_values.dart';

enum Species { HUMAN, ALIEN, UNKNOWN }

final speciesValues = EnumValues(
    {"Human": Species.HUMAN, "Alien": Species.ALIEN, "-": Species.UNKNOWN});
