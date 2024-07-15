import 'package:rick_and_morty/domain/entities/enum_values.dart';

enum Status { ALIVE, DEAD, UNKNOWN }

final statusValues = EnumValues({
  "Alive": Status.ALIVE,
  "Dead": Status.DEAD,
  "unknown": Status.UNKNOWN,
  "-": Status.UNKNOWN
});
