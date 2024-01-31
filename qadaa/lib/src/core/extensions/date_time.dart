extension DateTimeExtension on DateTime {
  DateTime dateOnly() {
    return DateTime(year, month, day);
  }

  DateTime setTime(DateTime time) {
    return copyWith(
      hour: time.hour,
      minute: time.minute,
      second: time.second,
      microsecond: time.microsecond,
      millisecond: time.millisecond,
    );
  }
}
