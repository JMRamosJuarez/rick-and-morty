class EnumValues<T> {
  final Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    this.reverseMap = map.map((k, v) => MapEntry(v, k));
    return this.reverseMap;
  }
}
