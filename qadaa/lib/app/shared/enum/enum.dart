String enumToMap(Enum e) {
  return e.toString().split('.').last;
}

T enumFromMap<T extends Enum>(String map, List<T> values, T defaultVal) {
  try {
    return values.singleWhere((v) => v.toString().split('.').last == map);
  } catch (e) {
    return defaultVal;
  }
}
