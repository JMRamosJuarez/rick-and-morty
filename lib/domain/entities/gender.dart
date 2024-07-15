import 'package:rick_and_morty/domain/entities/enum_values.dart';

enum Gender { MALE, FEMALE, UNKNOWN }

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.MALE,
  "unknown": Gender.UNKNOWN,
  "-": Gender.UNKNOWN
});
